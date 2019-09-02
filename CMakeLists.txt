cmake_minimum_required(VERSION 3.13)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(zxing VERSION 0.1)


message("Qt5")

if(EXISTS ${QT_CMAKE})
set(Qt5Core_DIR "${QT_CMAKE}/Qt5Core")
set(Qt5Gui_DIR "${QT_CMAKE}/Qt5Gui")
set(Qt5_DIR "${QT_CMAKE}/Qt5")
set(Qt5Network_DIR "${QT_CMAKE}/Qt5Network")
set(Qt5Qml_DIR "${QT_CMAKE}/Qt5Qml")
set(Qt5Quick_DIR "${QT_CMAKE}/Qt5Quick")
set(Qt5Widgets_DIR "${QT_CMAKE}/Qt5Widgets")
set(Qt5Multimedia_DIR "${QT_CMAKE}/Qt5Multimedia")

find_package(Qt5 COMPONENTS Core Gui Quick Multimedia Widgets WebEngine REQUIRED)

else()

hunter_add_package(Qt)
hunter_add_package(Qt COMPONENTS qtmultimedia)
hunter_add_package(Qt COMPONENTS qtdeclarative)

find_package(Qt5Core REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Multimedia REQUIRED)

endif()

if(ANDROID OR APPLE)
set(QUICK_COMPILER false)
else()
set(QUICK_COMPILER true)
find_package(Qt5QuickCompiler)
endif()

set(zxing_headers
        zxing/ZXing.h
        zxing/IllegalStateException.h
        zxing/InvertedLuminanceSource.h
        zxing/ChecksumException.h
        zxing/ResultPointCallback.h
        zxing/ResultPoint.h
        zxing/Result.h
        zxing/ResultMetadata.h
        zxing/ReaderException.h
        zxing/Reader.h
        zxing/NotFoundException.h
        zxing/MultiFormatReader.h
        zxing/LuminanceSource.h
        zxing/FormatException.h
        zxing/Exception.h
        zxing/DecodeHints.h
        zxing/BinaryBitmap.h
        zxing/Binarizer.h
        zxing/BarcodeFormat.h
        zxing/aztec/AztecReader.h
        zxing/aztec/AztecDetectorResult.h
        zxing/aztec/decoder/Decoder.h
        zxing/aztec/detector/Detector.h
        zxing/common/StringUtils.h
        zxing/common/Str.h
        zxing/common/Point.h
        zxing/common/PerspectiveTransform.h
        zxing/common/IllegalArgumentException.h
        zxing/common/HybridBinarizer.h
        zxing/common/GridSampler.h
        zxing/common/GreyscaleRotatedLuminanceSource.h
        zxing/common/GreyscaleLuminanceSource.h
        zxing/common/GlobalHistogramBinarizer.h
        zxing/common/DetectorResult.h
        zxing/common/DecoderResult.h
        zxing/common/Counted.h
        zxing/common/CharacterSetECI.h
        zxing/common/BitSource.h
        zxing/common/BitMatrix.h
        zxing/common/BitArray.h
        zxing/common/Array.h
        zxing/common/detector/MathUtils.h
        zxing/common/detector/JavaMath.h
        zxing/common/detector/WhiteRectangleDetector.h
        zxing/common/detector/MonochromeRectangleDetector.h
        zxing/common/reedsolomon/ReedSolomonException.h
        zxing/common/reedsolomon/ReedSolomonDecoder.h
        zxing/common/reedsolomon/GenericGFPoly.h
        zxing/common/reedsolomon/GenericGF.h
        zxing/common/ByteArray.h
        zxing/datamatrix/Version.h
        zxing/datamatrix/DataMatrixReader.h
        zxing/datamatrix/decoder/Decoder.h
        zxing/datamatrix/decoder/DecodedBitStreamParser.h
        zxing/datamatrix/decoder/DataBlock.h
        zxing/datamatrix/decoder/BitMatrixParser.h
        zxing/datamatrix/detector/DetectorException.h
        zxing/datamatrix/detector/Detector.h
        zxing/datamatrix/detector/CornerPoint.h
        zxing/oned/UPCEReader.h
        zxing/oned/UPCEANReader.h
        zxing/oned/UPCEANExtensionSupport.h
        zxing/oned/UPCEANExtension2Support.h
        zxing/oned/UPCEANExtension5Support.h
        zxing/oned/UPCAReader.h
        zxing/oned/OneDResultPoint.h
        zxing/oned/OneDReader.h
        zxing/oned/MultiFormatUPCEANReader.h
        zxing/oned/MultiFormatOneDReader.h
        zxing/oned/ITFReader.h
        zxing/oned/EAN13Reader.h
        zxing/oned/EAN8Reader.h
        zxing/oned/EANManufacturerOrgSupport.h
        zxing/oned/Code128Reader.h
        zxing/oned/Code39Reader.h
        zxing/oned/CodaBarReader.h
        zxing/oned/Code93Reader.h
        zxing/oned/rss/AbstractRSSReader.h
        zxing/oned/rss/DataCharacter.h
        zxing/oned/rss/FinderPattern.h
        zxing/oned/rss/Pair.h
        zxing/oned/rss/RSS14Reader.h
        zxing/oned/rss/RSSUtils.h
        zxing/oned/rss/expanded/decoders/AbstractExpandedDecoder.h
        zxing/oned/rss/expanded/decoders/AI013103decoder.h
        zxing/oned/rss/expanded/decoders/AI01320xDecoder.h
        zxing/oned/rss/expanded/decoders/AI01392xDecoder.h
        zxing/oned/rss/expanded/decoders/AI01393xDecoder.h
        zxing/oned/rss/expanded/decoders/AI013x0x1xDecoder.h
        zxing/oned/rss/expanded/decoders/AI013x0xDecoder.h
        zxing/oned/rss/expanded/decoders/AI01AndOtherAIs.h
        zxing/oned/rss/expanded/decoders/AI01decoder.h
        zxing/oned/rss/expanded/decoders/AI01weightDecoder.h
        zxing/oned/rss/expanded/decoders/AnyAIDecoder.h
        zxing/oned/rss/expanded/decoders/BlockParsedResult.h
        zxing/oned/rss/expanded/decoders/CurrentParsingState.h
        zxing/oned/rss/expanded/decoders/DecodedChar.h
        zxing/oned/rss/expanded/decoders/DecodedInformation.h
        zxing/oned/rss/expanded/decoders/DecodedNumeric.h
        zxing/oned/rss/expanded/decoders/DecodedObject.h
        zxing/oned/rss/expanded/decoders/FieldParser.h
        zxing/oned/rss/expanded/decoders/GeneralAppIdDecoder.h
        zxing/oned/rss/expanded/BitArrayBuilder.h
        zxing/oned/rss/expanded/ExpandedPair.h
        zxing/oned/rss/expanded/ExpandedRow.h
        zxing/oned/rss/expanded/RSSExpandedReader.h
        zxing/qrcode/Version.h
        zxing/qrcode/QRCodeReader.h
        zxing/qrcode/FormatInformation.h
        zxing/qrcode/ErrorCorrectionLevel.h
        zxing/qrcode/decoder/Mode.h
        zxing/qrcode/decoder/Decoder.h
        zxing/qrcode/decoder/DecodedBitStreamParser.h
        zxing/qrcode/decoder/DataMask.h
        zxing/qrcode/decoder/DataBlock.h
        zxing/qrcode/decoder/BitMatrixParser.h
        zxing/qrcode/detector/FinderPatternInfo.h
        zxing/qrcode/detector/FinderPatternFinder.h
        zxing/qrcode/detector/FinderPattern.h
        zxing/qrcode/detector/Detector.h
        zxing/qrcode/detector/AlignmentPatternFinder.h
        zxing/qrcode/detector/AlignmentPattern.h
        zxing/multi/MultipleBarcodeReader.h
        zxing/multi/GenericMultipleBarcodeReader.h
        zxing/multi/ByQuadrantReader.h
        zxing/multi/qrcode/QRCodeMultiReader.h
        zxing/multi/qrcode/detector/MultiFinderPatternFinder.h
        zxing/multi/qrcode/detector/MultiDetector.h
        zxing/pdf417/decoder/ec/ErrorCorrection.h
        zxing/pdf417/decoder/ec/ModulusGF.h
        zxing/pdf417/decoder/ec/ModulusPoly.h
        zxing/pdf417/decoder/BitMatrixParser.h
        zxing/pdf417/decoder/DecodedBitStreamParser.h
        zxing/pdf417/decoder/Decoder.h
        zxing/pdf417/detector/Detector.h
        zxing/pdf417/detector/LinesSampler.h
        zxing/pdf417/PDF417Reader.h
        zxing/qrcode/encoder/BlockPair.h
        zxing/qrcode/encoder/ByteMatrix.h
        zxing/qrcode/encoder/Encoder.h
        zxing/qrcode/encoder/MaskUtil.h
        zxing/qrcode/encoder/MatrixUtil.h
        zxing/qrcode/encoder/QRCode.h
        zxing/WriterException.h
        zxing/EncodeHint.h
        zxing/UnsupportedEncodingException.h
        zxing/common/reedsolomon/ReedSolomonEncoder.h
        zxing/common/Types.h)

set(zxing_source 
    zxing/ResultIO.cpp
    zxing/InvertedLuminanceSource.cpp
    zxing/ChecksumException.cpp
    zxing/ResultPointCallback.cpp
    zxing/ResultPoint.cpp
    zxing/Result.cpp
    zxing/ResultMetadata.cpp
    zxing/Reader.cpp
    zxing/MultiFormatReader.cpp
    zxing/LuminanceSource.cpp
    zxing/FormatException.cpp
    zxing/Exception.cpp
    zxing/DecodeHints.cpp
    zxing/BinaryBitmap.cpp
    zxing/Binarizer.cpp
    zxing/BarcodeFormat.cpp
    zxing/ReaderException.cpp
    zxing/IllegalStateException.cpp
    zxing/NotFoundException.cpp
    zxing/UnsupportedEncodingException.cpp
    zxing/WriterException.cpp
    zxing/aztec/AztecReader.cpp
    zxing/aztec/AztecDetectorResult.cpp
    zxing/common/Counted.cpp
    zxing/common/StringUtils.cpp
    zxing/common/Str.cpp
    zxing/common/PerspectiveTransform.cpp
    zxing/common/IllegalArgumentException.cpp
    zxing/common/HybridBinarizer.cpp
    zxing/common/GridSampler.cpp
    zxing/common/GreyscaleRotatedLuminanceSource.cpp
    zxing/common/GreyscaleLuminanceSource.cpp
    zxing/common/GlobalHistogramBinarizer.cpp
    zxing/common/DetectorResult.cpp
    zxing/common/DecoderResult.cpp
    zxing/common/CharacterSetECI.cpp
    zxing/common/BitSource.cpp
    zxing/common/BitMatrix.cpp
    zxing/common/BitArray.cpp
    zxing/common/BitArrayIO.cpp
    zxing/common/detector/WhiteRectangleDetector.cpp
    zxing/common/detector/MonochromeRectangleDetector.cpp
    zxing/common/reedsolomon/ReedSolomonException.cpp
    zxing/common/reedsolomon/ReedSolomonDecoder.cpp
    zxing/common/reedsolomon/GenericGFPoly.cpp
    zxing/common/reedsolomon/GenericGF.cpp
    zxing/datamatrix/DataMatrixReader.cpp
    zxing/oned/UPCEReader.cpp
    zxing/oned/UPCEANReader.cpp
    zxing/oned/UPCEANExtensionSupport.cpp
    zxing/oned/UPCEANExtension2Support.cpp
    zxing/oned/UPCEANExtension5Support.cpp
    zxing/oned/UPCAReader.cpp
    zxing/oned/OneDResultPoint.cpp
    zxing/oned/OneDReader.cpp
    zxing/oned/MultiFormatUPCEANReader.cpp
    zxing/oned/MultiFormatOneDReader.cpp
    zxing/oned/ITFReader.cpp
    zxing/oned/EAN13Reader.cpp
    zxing/oned/EAN8Reader.cpp
    zxing/oned/EANManufacturerOrgSupport.cpp
    zxing/oned/Code128Reader.cpp
    zxing/oned/Code39Reader.cpp
    zxing/oned/CodaBarReader.cpp
    zxing/oned/Code93Reader.cpp
    zxing/oned/rss/AbstractRSSReader.cpp
    zxing/oned/rss/DataCharacter.cpp
    zxing/oned/rss/FinderPattern.cpp
    zxing/oned/rss/Pair.cpp
    zxing/oned/rss/RSS14Reader.cpp
    zxing/oned/rss/RSSUtils.cpp
    zxing/oned/rss/expanded/BitArrayBuilder.cpp
    zxing/oned/rss/expanded/ExpandedPair.cpp
    zxing/oned/rss/expanded/ExpandedRow.cpp
    zxing/oned/rss/expanded/RSSExpandedReader.cpp
    zxing/oned/rss/expanded/decoders/AbstractExpandedDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI01AndOtherAIs.cpp
    zxing/oned/rss/expanded/decoders/AI01decoder.cpp
    zxing/oned/rss/expanded/decoders/AI01weightDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI013x0x1xDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI013x0xDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI01320xDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI01392xDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI01393xDecoder.cpp
    zxing/oned/rss/expanded/decoders/AI013103decoder.cpp
    zxing/oned/rss/expanded/decoders/AnyAIDecoder.cpp
    zxing/oned/rss/expanded/decoders/BlockParsedResult.cpp
    zxing/oned/rss/expanded/decoders/CurrentParsingState.cpp
    zxing/oned/rss/expanded/decoders/DecodedChar.cpp
    zxing/oned/rss/expanded/decoders/DecodedInformation.cpp
    zxing/oned/rss/expanded/decoders/DecodedNumeric.cpp
    zxing/oned/rss/expanded/decoders/DecodedObject.cpp
    zxing/oned/rss/expanded/decoders/FieldParser.cpp
    zxing/oned/rss/expanded/decoders/GeneralAppIdDecoder.cpp
    zxing/qrcode/QRCodeReader.cpp
    zxing/multi/MultipleBarcodeReader.cpp
    zxing/multi/GenericMultipleBarcodeReader.cpp
    zxing/multi/ByQuadrantReader.cpp
    zxing/multi/qrcode/QRCodeMultiReader.cpp
    zxing/multi/qrcode/detector/MultiFinderPatternFinder.cpp
    zxing/multi/qrcode/detector/MultiDetector.cpp
    zxing/aztec/decoder/AztecDecoder.cpp
    zxing/aztec/detector/AztecDetector.cpp
    zxing/datamatrix/DataMatrixVersion.cpp
    zxing/datamatrix/decoder/DataMatrixDecoder.cpp
    zxing/datamatrix/decoder/DataMatrixBitMatrixParser.cpp
    zxing/datamatrix/decoder/DataMatrixDataBlock.cpp
    zxing/datamatrix/decoder/DataMatrixDecodedBitStreamParser.cpp
    zxing/datamatrix/detector/DataMatrixCornerPoint.cpp
    zxing/datamatrix/detector/DataMatrixDetector.cpp
    zxing/datamatrix/detector/DataMatrixDetectorException.cpp
    zxing/qrcode/decoder/QRBitMatrixParser.cpp
    zxing/qrcode/decoder/QRDataBlock.cpp
    zxing/qrcode/decoder/QRDataMask.cpp
    zxing/qrcode/decoder/QRDecodedBitStreamParser.cpp
    zxing/qrcode/decoder/QRDecoder.cpp
    zxing/qrcode/decoder/QRMode.cpp
    zxing/qrcode/detector/QRAlignmentPattern.cpp
    zxing/qrcode/detector/QRAlignmentPatternFinder.cpp
    zxing/qrcode/detector/QRDetector.cpp
    zxing/qrcode/detector/QRFinderPattern.cpp
    zxing/qrcode/detector/QRFinderPatternFinder.cpp
    zxing/qrcode/detector/QRFinderPatternInfo.cpp
    zxing/qrcode/QRVersion.cpp
    zxing/qrcode/QRFormatInformation.cpp
    zxing/qrcode/QRErrorCorrectionLevel.cpp
    zxing/pdf417/decoder/ec/ErrorCorrection.cpp
    zxing/pdf417/decoder/ec/ModulusGF.cpp
    zxing/pdf417/decoder/ec/ModulusPoly.cpp
    zxing/pdf417/decoder/PDF417BitMatrixParser.cpp
    zxing/pdf417/decoder/PDF417DecodedBitStreamParser.cpp
    zxing/pdf417/decoder/PDF417Decoder.cpp
    zxing/pdf417/detector/PDF417Detector.cpp
    zxing/pdf417/detector/LinesSampler.cpp
    zxing/pdf417/PDF417Reader.cpp
    zxing/qrcode/encoder/ByteMatrix.cpp
    zxing/qrcode/encoder/QREncoder.cpp
    zxing/qrcode/encoder/MaskUtil.cpp
    zxing/qrcode/encoder/MatrixUtil.cpp
    zxing/qrcode/encoder/QRCode.cpp
    zxing/EncodeHint.cpp
    zxing/common/reedsolomon/ReedSolomonEncoder.cpp)


add_library( ${PROJECT_NAME} ${zxing_source}  )
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/)

target_compile_definitions(${PROJECT_NAME} PUBLIC 
        QZXING_LIBRARY
        ZXING_ICONV_CONST
        DISABLE_LIBRARY_FEATURES
        QZXING_MULTIMEDIA
        QZXING_QML
        NOFMAXL)

target_link_libraries(${PROJECT_NAME}
        PRIVATE 
                Qt5::Core 
                Qt5::Quick 
                Qt5::Gui
                Qt5::Multimedia
                Qt5::Widgets
        )

set(config_install_dir "lib/cmake/${PROJECT_NAME}")
set(include_install_dir "include")

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")

set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}::")

include(CMakePackageConfigHelpers)

# Use:
#   * PROJECT_VERSION
write_basic_package_version_file(
    "${version_config}" COMPATIBILITY SameMajorVersion
)

# Use variables:
#   * TARGETS_EXPORT_NAME
#   * PROJECT_NAME
configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    RUNTIME DESTINATION "bin"
    INCLUDES DESTINATION "${include_install_dir}"
)

install(
    DIRECTORY zxing
    DESTINATION "${include_install_dir}/zxing"
    FILES_MATCHING PATTERN "*.h"
)

install(
    FILES "${project_config}" "${version_config}"
    DESTINATION "${config_install_dir}"
)

install(
    EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE "${namespace}"
    DESTINATION "${config_install_dir}"
)

install(FILES ${la_config} DESTINATION lib)
