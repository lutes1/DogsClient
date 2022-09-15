# Type a 
if [ $ACTION == "indexbuild" ]; then
  echo "Not running Cuckoo generator during indexing."
  exit 0 
fi

# Skip for preview builds
if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
  echo "Not running Cuckoo generator during preview builds."
  exit 0
fi

# Define output file. Change "${PROJECT_DIR}/${PROJECT_NAME}Tests" to your test's root source folder, if it's not the default name.
OUTPUT_FILE="/Users/petrulutenco/Projects/DogsClient/DogsClientTests/Mocks/GeneratedMocks.swift"
echo "Generated Mocks File = ${OUTPUT_FILE}"

# Define input directory. Change "${PROJECT_DIR}/${PROJECT_NAME}" to your project's root source folder, if it's not the default name.
INPUT_DIR="/Users/petrulutenco/Projects/DogsClient/DogsClient"
echo "Mocks Input Directory = ${INPUT_DIR}"

# Generate mock files, include as many input files as you'd like to create mocks for.
"/Users/petrulutenco/Projects/DogsClient/DogsClientTests/run" --download generate --testable "DogsClient" \
--output "${OUTPUT_FILE}" \
"${INPUT_DIR}/Infrastructure/ViewModelProtocol.swift" \
"${INPUT_DIR}/Infrastructure/Networking/NetworkProviderProtocol.swift" \
"${INPUT_DIR}/Infrastructure/Networking/ApiProtocol.swift"
# ... and so forth, the last line should never end with a backslash

# After running once, locate `GeneratedMocks.swift` and drag it into your Xcode test target group.script or drag a script file from your workspace to insert its path.
