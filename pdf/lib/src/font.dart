/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of pdf;

class PdfFont extends PdfObject {
  /// The df type of the font, usually /Type1
  final String subtype;

  /// Constructs a [PdfFont]. This will attempt to map the font from a known
  /// font name to that in Pdf, defaulting to Helvetica if not possible.
  ///
  /// @param name The document name, ie /F1
  /// @param subtype The pdf type, ie /Type1
  /// @param baseFont The font name, ie /Helvetica
  PdfFont._create(PdfDocument pdfDocument, {@required this.subtype})
      : super(pdfDocument, "/Font") {
    pdfDocument.fonts.add(this);
  }

  String get name => "/F$objser";

  String get fontName => null;

  /// @param os OutputStream to send the object to
  @override
  void _prepare() {
    super._prepare();

    params["/Subtype"] = PdfStream.string(subtype);
    params["/Name"] = PdfStream.string(name);
    params["/Encoding"] = PdfStream.string("/WinAnsiEncoding");
  }

  double glyphAdvance(int charCode) {
    return 0.454;
  }

  PdfRect glyphBounds(int charCode) {
    return PdfRect(0.0, 0.0, glyphAdvance(charCode), 1.0);
  }

  PdfRect stringBounds(String s) {
    var chars = latin1.encode(s);

    if (chars.length == 0) return const PdfRect(0.0, 0.0, 0.0, 0.0);

    var n = 0;
    var c = chars[n];
    var r = glyphBounds(c);
    var x = r.x;
    var y = r.y;
    var h = r.height;
    var w = n == chars.length - 1 ? r.width : glyphAdvance(c);

    while (++n < chars.length) {
      c = chars[n];
      r = glyphBounds(c);
      if (r.y < y) y = r.y;
      if (r.height > h) h = r.height;
      w += n == chars.length - 1 ? r.width : glyphAdvance(c);
    }

    return PdfRect(x, y, w, h);
  }

  PdfPoint stringSize(String s) {
    var chars = latin1.encode(s);

    var w = 0.0;
    var h = 0.0;

    for (var c in chars) {
      var r = glyphBounds(c);
      if (r.height > h) h = r.height;
      w += glyphAdvance(c);
    }

    return PdfPoint(w, h);
  }

  factory PdfFont.courier(PdfDocument pdfDocument) {
    return PdfType1Font._create(pdfDocument, "Courier", 0.910, -0.220,
        List<double>.generate(256, (int index) => 0.600));
  }

  factory PdfFont.courierBold(PdfDocument pdfDocument) {
    return PdfType1Font._create(pdfDocument, "Courier-Bold", 0.910, -0.220,
        List<double>.generate(256, (int index) => 0.600));
  }

  factory PdfFont.courierBoldOblique(PdfDocument pdfDocument) {
    return PdfType1Font._create(pdfDocument, "Courier-BoldOblique", 0.910,
        -0.220, List<double>.generate(256, (int index) => 0.600));
  }

  factory PdfFont.courierOblique(PdfDocument pdfDocument) {
    return PdfType1Font._create(pdfDocument, "Courier-Oblique", 0.910, -0.220,
        List<double>.generate(256, (int index) => 0.600));
  }

  factory PdfFont.helvetica(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Helvetica", 0.931, -0.225, <double>[
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.278,
      0.278,
      0.355,
      0.556,
      0.556,
      0.889,
      0.667,
      0.191,
      0.333,
      0.333,
      0.389,
      0.584,
      0.278,
      0.333,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.278,
      0.278,
      0.584,
      0.584,
      0.584,
      0.556,
      1.015,
      0.667,
      0.667,
      0.722,
      0.722,
      0.667,
      0.611,
      0.778,
      0.722,
      0.278,
      0.500,
      0.667,
      0.556,
      0.833,
      0.722,
      0.778,
      0.667,
      0.778,
      0.722,
      0.667,
      0.611,
      0.722,
      0.667,
      0.944,
      0.667,
      0.667,
      0.611,
      0.278,
      0.278,
      0.277,
      0.469,
      0.556,
      0.333,
      0.556,
      0.556,
      0.500,
      0.556,
      0.556,
      0.278,
      0.556,
      0.556,
      0.222,
      0.222,
      0.500,
      0.222,
      0.833,
      0.556,
      0.556,
      0.556,
      0.556,
      0.333,
      0.500,
      0.278,
      0.556,
      0.500,
      0.722,
      0.500,
      0.500,
      0.500,
      0.334,
      0.260,
      0.334,
      0.584,
      0.500,
      0.655,
      0.500,
      0.222,
      0.278,
      0.333,
      1.000,
      0.556,
      0.556,
      0.333,
      1.000,
      0.667,
      0.250,
      1.000,
      0.500,
      0.611,
      0.500,
      0.500,
      0.222,
      0.221,
      0.333,
      0.333,
      0.350,
      0.556,
      1.000,
      0.333,
      1.000,
      0.500,
      0.250,
      0.938,
      0.500,
      0.500,
      0.667,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.260,
      0.556,
      0.333,
      0.737,
      0.370,
      0.448,
      0.584,
      0.333,
      0.737,
      0.333,
      0.606,
      0.584,
      0.350,
      0.350,
      0.333,
      0.556,
      0.537,
      0.278,
      0.333,
      0.350,
      0.365,
      0.448,
      0.869,
      0.869,
      0.879,
      0.556,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      1.000,
      0.722,
      0.667,
      0.667,
      0.667,
      0.667,
      0.278,
      0.278,
      0.278,
      0.278,
      0.722,
      0.722,
      0.778,
      0.778,
      0.778,
      0.778,
      0.778,
      0.584,
      0.778,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.666,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.896,
      0.500,
      0.556,
      0.556,
      0.556,
      0.556,
      0.251,
      0.251,
      0.251,
      0.251,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.584,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.500,
      0.555,
      0.500
    ]);
  }

  factory PdfFont.helveticaBold(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Helvetica-Bold", 0.962, -0.228, <double>[
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.333,
      0.474,
      0.556,
      0.556,
      0.889,
      0.722,
      0.238,
      0.333,
      0.333,
      0.389,
      0.584,
      0.278,
      0.333,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.333,
      0.333,
      0.584,
      0.584,
      0.584,
      0.611,
      0.975,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.611,
      0.778,
      0.722,
      0.278,
      0.556,
      0.722,
      0.611,
      0.833,
      0.722,
      0.778,
      0.667,
      0.778,
      0.722,
      0.667,
      0.611,
      0.722,
      0.667,
      0.944,
      0.667,
      0.667,
      0.611,
      0.333,
      0.278,
      0.333,
      0.584,
      0.556,
      0.333,
      0.556,
      0.611,
      0.556,
      0.611,
      0.556,
      0.333,
      0.611,
      0.611,
      0.278,
      0.278,
      0.556,
      0.278,
      0.889,
      0.611,
      0.611,
      0.611,
      0.611,
      0.389,
      0.556,
      0.333,
      0.611,
      0.556,
      0.778,
      0.556,
      0.556,
      0.500,
      0.389,
      0.280,
      0.389,
      0.584,
      0.350,
      0.556,
      0.350,
      0.278,
      0.556,
      0.500,
      1.000,
      0.556,
      0.556,
      0.333,
      1.000,
      0.667,
      0.333,
      1.000,
      0.350,
      0.611,
      0.350,
      0.350,
      0.278,
      0.278,
      0.500,
      0.500,
      0.350,
      0.556,
      1.000,
      0.333,
      1.000,
      0.556,
      0.333,
      0.944,
      0.350,
      0.500,
      0.667,
      0.278,
      0.333,
      0.556,
      0.556,
      0.556,
      0.556,
      0.280,
      0.556,
      0.333,
      0.737,
      0.370,
      0.556,
      0.584,
      0.333,
      0.737,
      0.333,
      0.400,
      0.584,
      0.333,
      0.333,
      0.333,
      0.611,
      0.556,
      0.278,
      0.333,
      0.333,
      0.365,
      0.556,
      0.834,
      0.834,
      0.834,
      0.611,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      1.000,
      0.722,
      0.667,
      0.667,
      0.667,
      0.667,
      0.278,
      0.278,
      0.278,
      0.278,
      0.722,
      0.722,
      0.778,
      0.778,
      0.778,
      0.778,
      0.778,
      0.584,
      0.778,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.667,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.889,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.278,
      0.278,
      0.278,
      0.278,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.584,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.556,
      0.611,
      0.556
    ]);
  }

  factory PdfFont.helveticaBoldOblique(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Helvetica-BoldOblique", 0.962, -0.228, <double>[
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.333,
      0.474,
      0.556,
      0.556,
      0.889,
      0.722,
      0.238,
      0.333,
      0.333,
      0.389,
      0.584,
      0.278,
      0.333,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.333,
      0.333,
      0.584,
      0.584,
      0.584,
      0.611,
      0.975,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.611,
      0.778,
      0.722,
      0.278,
      0.556,
      0.722,
      0.611,
      0.833,
      0.722,
      0.778,
      0.667,
      0.778,
      0.722,
      0.667,
      0.611,
      0.722,
      0.667,
      0.944,
      0.667,
      0.667,
      0.611,
      0.333,
      0.278,
      0.333,
      0.584,
      0.556,
      0.333,
      0.556,
      0.611,
      0.556,
      0.611,
      0.556,
      0.333,
      0.611,
      0.611,
      0.278,
      0.278,
      0.556,
      0.278,
      0.889,
      0.611,
      0.611,
      0.611,
      0.611,
      0.389,
      0.556,
      0.333,
      0.611,
      0.556,
      0.778,
      0.556,
      0.556,
      0.500,
      0.389,
      0.280,
      0.389,
      0.584,
      0.350,
      0.556,
      0.350,
      0.278,
      0.556,
      0.500,
      1.000,
      0.556,
      0.556,
      0.333,
      1.000,
      0.667,
      0.333,
      1.000,
      0.350,
      0.611,
      0.350,
      0.350,
      0.278,
      0.278,
      0.500,
      0.500,
      0.350,
      0.556,
      1.000,
      0.333,
      1.000,
      0.556,
      0.333,
      0.944,
      0.350,
      0.500,
      0.667,
      0.278,
      0.333,
      0.556,
      0.556,
      0.556,
      0.556,
      0.280,
      0.556,
      0.333,
      0.737,
      0.370,
      0.556,
      0.584,
      0.333,
      0.737,
      0.333,
      0.400,
      0.584,
      0.333,
      0.333,
      0.333,
      0.611,
      0.556,
      0.278,
      0.333,
      0.333,
      0.365,
      0.556,
      0.834,
      0.834,
      0.834,
      0.611,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      1.000,
      0.722,
      0.667,
      0.667,
      0.667,
      0.667,
      0.278,
      0.278,
      0.278,
      0.278,
      0.722,
      0.722,
      0.778,
      0.778,
      0.778,
      0.778,
      0.778,
      0.584,
      0.778,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.667,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.889,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.278,
      0.278,
      0.278,
      0.278,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.584,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.556,
      0.611,
      0.556
    ]);
  }

  factory PdfFont.helveticaOblique(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Helvetica-Oblique", 0.931, -0.225, <double>[
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.278,
      0.355,
      0.556,
      0.556,
      0.889,
      0.667,
      0.191,
      0.333,
      0.333,
      0.389,
      0.584,
      0.278,
      0.333,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.278,
      0.278,
      0.584,
      0.584,
      0.584,
      0.556,
      1.015,
      0.667,
      0.667,
      0.722,
      0.722,
      0.667,
      0.611,
      0.778,
      0.722,
      0.278,
      0.500,
      0.667,
      0.556,
      0.833,
      0.722,
      0.778,
      0.667,
      0.778,
      0.722,
      0.667,
      0.611,
      0.722,
      0.667,
      0.944,
      0.667,
      0.667,
      0.611,
      0.278,
      0.278,
      0.278,
      0.469,
      0.556,
      0.333,
      0.556,
      0.556,
      0.500,
      0.556,
      0.556,
      0.278,
      0.556,
      0.556,
      0.222,
      0.222,
      0.500,
      0.222,
      0.833,
      0.556,
      0.556,
      0.556,
      0.556,
      0.333,
      0.500,
      0.278,
      0.556,
      0.500,
      0.722,
      0.500,
      0.500,
      0.500,
      0.334,
      0.260,
      0.334,
      0.584,
      0.350,
      0.556,
      0.350,
      0.222,
      0.556,
      0.333,
      1.000,
      0.556,
      0.556,
      0.333,
      1.000,
      0.667,
      0.333,
      1.000,
      0.350,
      0.611,
      0.350,
      0.350,
      0.222,
      0.222,
      0.333,
      0.333,
      0.350,
      0.556,
      1.000,
      0.333,
      1.000,
      0.500,
      0.333,
      0.944,
      0.350,
      0.500,
      0.667,
      0.278,
      0.333,
      0.556,
      0.556,
      0.556,
      0.556,
      0.260,
      0.556,
      0.333,
      0.737,
      0.370,
      0.556,
      0.584,
      0.333,
      0.737,
      0.333,
      0.400,
      0.584,
      0.333,
      0.333,
      0.333,
      0.556,
      0.537,
      0.278,
      0.333,
      0.333,
      0.365,
      0.556,
      0.834,
      0.834,
      0.834,
      0.611,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      1.000,
      0.722,
      0.667,
      0.667,
      0.667,
      0.667,
      0.278,
      0.278,
      0.278,
      0.278,
      0.722,
      0.722,
      0.778,
      0.778,
      0.778,
      0.778,
      0.778,
      0.584,
      0.778,
      0.722,
      0.722,
      0.722,
      0.722,
      0.667,
      0.667,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.889,
      0.500,
      0.556,
      0.556,
      0.556,
      0.556,
      0.278,
      0.278,
      0.278,
      0.278,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.556,
      0.584,
      0.611,
      0.556,
      0.556,
      0.556,
      0.556,
      0.500,
      0.556,
      0.500
    ]);
  }

  factory PdfFont.times(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Times-Roman", 0.898, -0.218, <double>[
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.333,
      0.408,
      0.500,
      0.500,
      0.833,
      0.778,
      0.180,
      0.333,
      0.333,
      0.500,
      0.564,
      0.250,
      0.333,
      0.250,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.278,
      0.278,
      0.564,
      0.564,
      0.564,
      0.444,
      0.921,
      0.722,
      0.667,
      0.667,
      0.722,
      0.611,
      0.556,
      0.722,
      0.722,
      0.333,
      0.389,
      0.722,
      0.611,
      0.889,
      0.722,
      0.722,
      0.556,
      0.722,
      0.667,
      0.556,
      0.611,
      0.722,
      0.722,
      0.944,
      0.722,
      0.722,
      0.611,
      0.333,
      0.278,
      0.333,
      0.469,
      0.500,
      0.333,
      0.444,
      0.500,
      0.444,
      0.500,
      0.444,
      0.333,
      0.500,
      0.500,
      0.278,
      0.278,
      0.500,
      0.278,
      0.778,
      0.500,
      0.500,
      0.500,
      0.500,
      0.333,
      0.389,
      0.278,
      0.500,
      0.500,
      0.722,
      0.500,
      0.500,
      0.444,
      0.480,
      0.200,
      0.480,
      0.541,
      0.350,
      0.500,
      0.350,
      0.333,
      0.500,
      0.444,
      1.000,
      0.500,
      0.500,
      0.333,
      1.000,
      0.556,
      0.333,
      0.889,
      0.350,
      0.611,
      0.350,
      0.350,
      0.333,
      0.333,
      0.444,
      0.444,
      0.350,
      0.500,
      1.000,
      0.333,
      0.980,
      0.389,
      0.333,
      0.722,
      0.350,
      0.444,
      0.722,
      0.250,
      0.333,
      0.500,
      0.500,
      0.500,
      0.500,
      0.200,
      0.500,
      0.333,
      0.760,
      0.276,
      0.500,
      0.564,
      0.333,
      0.760,
      0.333,
      0.400,
      0.564,
      0.300,
      0.300,
      0.333,
      0.500,
      0.453,
      0.250,
      0.333,
      0.300,
      0.310,
      0.500,
      0.750,
      0.750,
      0.750,
      0.444,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.889,
      0.667,
      0.611,
      0.611,
      0.611,
      0.611,
      0.333,
      0.333,
      0.333,
      0.333,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.564,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.556,
      0.500,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.667,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.278,
      0.278,
      0.278,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.564,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500
    ]);
  }

  factory PdfFont.timesBold(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Times-Bold", 0.935, -0.218, <double>[
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.333,
      0.555,
      0.500,
      0.500,
      1.000,
      0.833,
      0.278,
      0.333,
      0.333,
      0.500,
      0.570,
      0.250,
      0.333,
      0.250,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.333,
      0.333,
      0.570,
      0.570,
      0.570,
      0.500,
      0.930,
      0.722,
      0.667,
      0.722,
      0.722,
      0.667,
      0.611,
      0.778,
      0.778,
      0.389,
      0.500,
      0.778,
      0.667,
      0.944,
      0.722,
      0.778,
      0.611,
      0.778,
      0.722,
      0.556,
      0.667,
      0.722,
      0.722,
      1.000,
      0.722,
      0.722,
      0.667,
      0.333,
      0.278,
      0.333,
      0.581,
      0.500,
      0.333,
      0.500,
      0.556,
      0.444,
      0.556,
      0.444,
      0.333,
      0.500,
      0.556,
      0.278,
      0.333,
      0.556,
      0.278,
      0.833,
      0.556,
      0.500,
      0.556,
      0.556,
      0.444,
      0.389,
      0.333,
      0.556,
      0.500,
      0.722,
      0.500,
      0.500,
      0.444,
      0.394,
      0.220,
      0.394,
      0.520,
      0.350,
      0.500,
      0.350,
      0.333,
      0.500,
      0.500,
      1.000,
      0.500,
      0.500,
      0.333,
      1.000,
      0.556,
      0.333,
      1.000,
      0.350,
      0.667,
      0.350,
      0.350,
      0.333,
      0.333,
      0.500,
      0.500,
      0.350,
      0.500,
      1.000,
      0.333,
      1.000,
      0.389,
      0.333,
      0.722,
      0.350,
      0.444,
      0.722,
      0.250,
      0.333,
      0.500,
      0.500,
      0.500,
      0.500,
      0.220,
      0.500,
      0.333,
      0.747,
      0.300,
      0.500,
      0.570,
      0.333,
      0.747,
      0.333,
      0.400,
      0.570,
      0.300,
      0.300,
      0.333,
      0.556,
      0.540,
      0.250,
      0.333,
      0.300,
      0.330,
      0.500,
      0.750,
      0.750,
      0.750,
      0.500,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      1.000,
      0.722,
      0.667,
      0.667,
      0.667,
      0.667,
      0.389,
      0.389,
      0.389,
      0.389,
      0.722,
      0.722,
      0.778,
      0.778,
      0.778,
      0.778,
      0.778,
      0.570,
      0.778,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.611,
      0.556,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.722,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.278,
      0.278,
      0.278,
      0.278,
      0.500,
      0.556,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.570,
      0.500,
      0.556,
      0.556,
      0.556,
      0.556,
      0.500,
      0.556,
      0.500
    ]);
  }

  factory PdfFont.timesBoldItalic(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Times-BoldItalic", 0.921, -0.218, <double>[
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.389,
      0.555,
      0.500,
      0.500,
      0.833,
      0.778,
      0.278,
      0.333,
      0.333,
      0.500,
      0.570,
      0.250,
      0.333,
      0.250,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.333,
      0.333,
      0.570,
      0.570,
      0.570,
      0.500,
      0.832,
      0.667,
      0.667,
      0.667,
      0.722,
      0.667,
      0.667,
      0.722,
      0.778,
      0.389,
      0.500,
      0.667,
      0.611,
      0.889,
      0.722,
      0.722,
      0.611,
      0.722,
      0.667,
      0.556,
      0.611,
      0.722,
      0.667,
      0.889,
      0.667,
      0.611,
      0.611,
      0.333,
      0.278,
      0.333,
      0.570,
      0.500,
      0.333,
      0.500,
      0.500,
      0.444,
      0.500,
      0.444,
      0.333,
      0.500,
      0.556,
      0.278,
      0.278,
      0.500,
      0.278,
      0.778,
      0.556,
      0.500,
      0.500,
      0.500,
      0.389,
      0.389,
      0.278,
      0.556,
      0.444,
      0.667,
      0.500,
      0.444,
      0.389,
      0.348,
      0.220,
      0.348,
      0.570,
      0.350,
      0.500,
      0.350,
      0.333,
      0.500,
      0.500,
      1.000,
      0.500,
      0.500,
      0.333,
      1.000,
      0.556,
      0.333,
      0.944,
      0.350,
      0.611,
      0.350,
      0.350,
      0.333,
      0.333,
      0.500,
      0.500,
      0.350,
      0.500,
      1.000,
      0.333,
      1.000,
      0.389,
      0.333,
      0.722,
      0.350,
      0.389,
      0.611,
      0.250,
      0.389,
      0.500,
      0.500,
      0.500,
      0.500,
      0.220,
      0.500,
      0.333,
      0.747,
      0.266,
      0.500,
      0.606,
      0.333,
      0.747,
      0.333,
      0.400,
      0.570,
      0.300,
      0.300,
      0.333,
      0.576,
      0.500,
      0.250,
      0.333,
      0.300,
      0.300,
      0.500,
      0.750,
      0.750,
      0.750,
      0.500,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      0.944,
      0.667,
      0.667,
      0.667,
      0.667,
      0.667,
      0.389,
      0.389,
      0.389,
      0.389,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.570,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.611,
      0.611,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.722,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.278,
      0.278,
      0.278,
      0.278,
      0.500,
      0.556,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.570,
      0.500,
      0.556,
      0.556,
      0.556,
      0.556,
      0.444,
      0.500,
      0.444
    ]);
  }

  factory PdfFont.timesItalic(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "Times-Italic", 0.883, -0.217, <double>[
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.250,
      0.333,
      0.420,
      0.500,
      0.500,
      0.833,
      0.778,
      0.214,
      0.333,
      0.333,
      0.500,
      0.675,
      0.250,
      0.333,
      0.250,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.333,
      0.333,
      0.675,
      0.675,
      0.675,
      0.500,
      0.920,
      0.611,
      0.611,
      0.667,
      0.722,
      0.611,
      0.611,
      0.722,
      0.722,
      0.333,
      0.444,
      0.667,
      0.556,
      0.833,
      0.667,
      0.722,
      0.611,
      0.722,
      0.611,
      0.500,
      0.556,
      0.722,
      0.611,
      0.833,
      0.611,
      0.556,
      0.556,
      0.389,
      0.278,
      0.389,
      0.422,
      0.500,
      0.333,
      0.500,
      0.500,
      0.444,
      0.500,
      0.444,
      0.278,
      0.500,
      0.500,
      0.278,
      0.278,
      0.444,
      0.278,
      0.722,
      0.500,
      0.500,
      0.500,
      0.500,
      0.389,
      0.389,
      0.278,
      0.500,
      0.444,
      0.667,
      0.444,
      0.444,
      0.389,
      0.400,
      0.275,
      0.400,
      0.541,
      0.350,
      0.500,
      0.350,
      0.333,
      0.500,
      0.556,
      0.889,
      0.500,
      0.500,
      0.333,
      1.000,
      0.500,
      0.333,
      0.944,
      0.350,
      0.556,
      0.350,
      0.350,
      0.333,
      0.333,
      0.556,
      0.556,
      0.350,
      0.500,
      0.889,
      0.333,
      0.980,
      0.389,
      0.333,
      0.667,
      0.350,
      0.389,
      0.556,
      0.250,
      0.389,
      0.500,
      0.500,
      0.500,
      0.500,
      0.275,
      0.500,
      0.333,
      0.760,
      0.276,
      0.500,
      0.675,
      0.333,
      0.760,
      0.333,
      0.400,
      0.675,
      0.300,
      0.300,
      0.333,
      0.500,
      0.523,
      0.250,
      0.333,
      0.300,
      0.310,
      0.500,
      0.750,
      0.750,
      0.750,
      0.500,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.611,
      0.889,
      0.667,
      0.611,
      0.611,
      0.611,
      0.611,
      0.333,
      0.333,
      0.333,
      0.333,
      0.722,
      0.667,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.675,
      0.722,
      0.722,
      0.722,
      0.722,
      0.722,
      0.556,
      0.611,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.667,
      0.444,
      0.444,
      0.444,
      0.444,
      0.444,
      0.278,
      0.278,
      0.278,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.675,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.444,
      0.500,
      0.444
    ]);
  }

  factory PdfFont.symbol(PdfDocument pdfDocument) {
    return PdfType1Font._create(pdfDocument, "Symbol", 1.010, -0.293, <double>[
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.250,
      0.333,
      0.713,
      0.500,
      0.549,
      0.833,
      0.778,
      0.439,
      0.333,
      0.333,
      0.500,
      0.549,
      0.250,
      0.549,
      0.250,
      0.278,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.500,
      0.278,
      0.278,
      0.549,
      0.549,
      0.549,
      0.444,
      0.549,
      0.722,
      0.667,
      0.722,
      0.612,
      0.611,
      0.763,
      0.603,
      0.722,
      0.333,
      0.631,
      0.722,
      0.686,
      0.889,
      0.722,
      0.722,
      0.768,
      0.741,
      0.556,
      0.592,
      0.611,
      0.690,
      0.439,
      0.768,
      0.645,
      0.795,
      0.611,
      0.333,
      0.863,
      0.333,
      0.658,
      0.500,
      0.500,
      0.631,
      0.549,
      0.549,
      0.494,
      0.439,
      0.521,
      0.411,
      0.603,
      0.329,
      0.603,
      0.549,
      0.549,
      0.576,
      0.521,
      0.549,
      0.549,
      0.521,
      0.549,
      0.603,
      0.439,
      0.576,
      0.713,
      0.686,
      0.493,
      0.686,
      0.494,
      0.480,
      0.200,
      0.480,
      0.549,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.587,
      0.750,
      0.620,
      0.247,
      0.549,
      0.167,
      0.713,
      0.500,
      0.753,
      0.753,
      0.753,
      0.753,
      1.042,
      0.987,
      0.603,
      0.987,
      0.603,
      0.400,
      0.549,
      0.411,
      0.549,
      0.549,
      0.713,
      0.494,
      0.460,
      0.549,
      0.549,
      0.549,
      0.549,
      1.000,
      0.603,
      1.000,
      0.658,
      0.823,
      0.686,
      0.795,
      0.987,
      0.768,
      0.768,
      0.823,
      0.768,
      0.768,
      0.713,
      0.713,
      0.713,
      0.713,
      0.713,
      0.713,
      0.713,
      0.768,
      0.713,
      0.790,
      0.790,
      0.890,
      0.823,
      0.549,
      0.250,
      0.713,
      0.603,
      0.603,
      1.042,
      0.987,
      0.603,
      0.987,
      0.603,
      0.494,
      0.329,
      0.790,
      0.790,
      0.786,
      0.713,
      0.384,
      0.384,
      0.384,
      0.384,
      0.384,
      0.384,
      0.494,
      0.494,
      0.494,
      0.494,
      0.587,
      0.329,
      0.274,
      0.686,
      0.686,
      0.686,
      0.384,
      0.384,
      0.384,
      0.384,
      0.384,
      0.384,
      0.494,
      0.494,
      0.494,
      0.587
    ]);
  }

  factory PdfFont.zapfDingbats(PdfDocument pdfDocument) {
    return PdfType1Font._create(
        pdfDocument, "ZapfDingbats", 0.820, -0.143, <double>[
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.278,
      0.974,
      0.961,
      0.974,
      0.980,
      0.719,
      0.789,
      0.790,
      0.791,
      0.690,
      0.960,
      0.939,
      0.549,
      0.855,
      0.911,
      0.933,
      0.911,
      0.945,
      0.974,
      0.755,
      0.846,
      0.762,
      0.761,
      0.571,
      0.677,
      0.763,
      0.760,
      0.759,
      0.754,
      0.494,
      0.552,
      0.537,
      0.577,
      0.692,
      0.786,
      0.788,
      0.788,
      0.790,
      0.793,
      0.794,
      0.816,
      0.823,
      0.789,
      0.841,
      0.823,
      0.833,
      0.816,
      0.831,
      0.923,
      0.744,
      0.723,
      0.749,
      0.790,
      0.792,
      0.695,
      0.776,
      0.768,
      0.792,
      0.759,
      0.707,
      0.708,
      0.682,
      0.701,
      0.826,
      0.815,
      0.789,
      0.789,
      0.707,
      0.687,
      0.696,
      0.689,
      0.786,
      0.787,
      0.713,
      0.791,
      0.785,
      0.791,
      0.873,
      0.761,
      0.762,
      0.762,
      0.759,
      0.759,
      0.892,
      0.892,
      0.788,
      0.784,
      0.438,
      0.138,
      0.277,
      0.415,
      0.392,
      0.392,
      0.668,
      0.668,
      0.746,
      0.390,
      0.390,
      0.317,
      0.317,
      0.276,
      0.276,
      0.509,
      0.509,
      0.410,
      0.410,
      0.234,
      0.234,
      0.334,
      0.334,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.746,
      0.732,
      0.544,
      0.544,
      0.910,
      0.667,
      0.760,
      0.760,
      0.776,
      0.595,
      0.694,
      0.626,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.788,
      0.894,
      0.838,
      1.016,
      0.458,
      0.748,
      0.924,
      0.748,
      0.918,
      0.927,
      0.928,
      0.928,
      0.834,
      0.873,
      0.828,
      0.924,
      0.924,
      0.917,
      0.930,
      0.931,
      0.463,
      0.883,
      0.836,
      0.836,
      0.867,
      0.867,
      0.696,
      0.696,
      0.874,
      0.746,
      0.874,
      0.760,
      0.946,
      0.771,
      0.865,
      0.771,
      0.888,
      0.967,
      0.888,
      0.831,
      0.873,
      0.927,
      0.970,
      0.918,
      0.746
    ]);
  }
}
