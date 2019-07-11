From: Grant Hernandez <granthernandez@google.com>
Subject: [PATCH] Input: gtco - bounds check collection indent level
Date: Thu, 11 Jul 2019 15:22:32 -0700
Message-ID: <20190711222232.77701-1-granthernandez@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Grant Hernandez <granthernandez@google.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The GTCO tablet input driver configures itself from an HID report sent
via USB during the initial enumeration process. Some debugging messages
are generated during the parsing. A debugging message indentation
counter is not bounds checked, leading to the ability for a specially
crafted HID report to cause '-' and null bytes be written past the end
of the indentation array. As long as the kernel has CONFIG_DYNAMIC_DEBUG
enabled, this code will not be optimized out.  This was discovered
during code review after a previous syzkaller bug was found in this
driver.

Cc: stable@vger.kernel.org
Signed-off-by: Grant Hernandez <granthernandez@google.com>
---
 drivers/input/tablet/gtco.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index 4b8b9d7aa75e..9771052ed027 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -78,6 +78,7 @@ Scott Hill shill@gtcocalcomp.com
 
 /* Max size of a single report */
 #define REPORT_MAX_SIZE       10
+#define MAX_COLLECTION_LEVELS  10
 
 
 /* Bitmask whether pen is in range */
@@ -223,8 +224,7 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 	char  maintype = 'x';
 	char  globtype[12];
 	int   indent = 0;
-	char  indentstr[10] = "";
-
+	char  indentstr[MAX_COLLECTION_LEVELS+1] = {0};
 
 	dev_dbg(ddev, "======>>>>>>PARSE<<<<<<======\n");
 
@@ -350,6 +350,12 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 			case TAG_MAIN_COL_START:
 				maintype = 'S';
 
+				if (indent == MAX_COLLECTION_LEVELS) {
+					dev_err(ddev, "Collection level %d would exceed limit of %d\n",
+						indent+1, MAX_COLLECTION_LEVELS);
+					break;
+				}
+
 				if (data == 0) {
 					dev_dbg(ddev, "======>>>>>> Physical\n");
 					strcpy(globtype, "Physical");
@@ -369,8 +375,15 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 				break;
 
 			case TAG_MAIN_COL_END:
-				dev_dbg(ddev, "<<<<<<======\n");
 				maintype = 'E';
+
+				if (indent == 0) {
+					dev_err(ddev, "Collection level already at zero\n");
+					break;
+				}
+
+				dev_dbg(ddev, "<<<<<<======\n");
+
 				indent--;
 				for (x = 0; x < indent; x++)
 					indentstr[x] = '-';
-- 
2.22.0.410.gd8fdbe21b5-goog
