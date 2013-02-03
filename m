From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 01/14] Input: ALPS - Document the alps.h data structures
Date: Sun,  3 Feb 2013 15:56:41 -0800
Message-ID: <1359935815-13507-2-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:52931 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5R (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:17 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2384613dak.19
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:16 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Add kernel-doc markup.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.h |   74 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index ae1ac35..67be4e5 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -17,30 +17,78 @@
 #define ALPS_PROTO_V3	2
 #define ALPS_PROTO_V4	3
 
+/**
+ * struct alps_model_info - touchpad ID table
+ * @signature: E7 response string to match.
+ * @command_mode_resp: For V3/V4 touchpads, the final byte of the EC response
+ *   (aka command mode response) identifies the firmware minor version.  This
+ *   can be used to distinguish different hardware models which are not
+ *   uniquely identifiable through their E7 responses.
+ * @proto_version: Indicates V1/V2/V3/...
+ * @byte0: Helps figure out whether a position report packet matches the
+ *   known format for this model.  The first byte of the report, ANDed with
+ *   mask0, should match byte0.
+ * @mask0: The mask used to check the first byte of the report.
+ * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
+ *
+ * Many (but not all) ALPS touchpads can be identified by looking at the
+ * values returned in the "E7 report" and/or the "EC report."  This table
+ * lists a number of such touchpads.
+ */
 struct alps_model_info {
-        unsigned char signature[3];
-	unsigned char command_mode_resp; /* v3/v4 only */
+	unsigned char signature[3];
+	unsigned char command_mode_resp;
 	unsigned char proto_version;
-        unsigned char byte0, mask0;
-        unsigned char flags;
+	unsigned char byte0, mask0;
+	unsigned char flags;
 };
 
+/**
+ * struct alps_nibble_commands - encodings for register accesses
+ * @command: PS/2 command used for the nibble
+ * @data: Data supplied as an argument to the PS/2 command, if applicable
+ *
+ * The ALPS protocol uses magic sequences to transmit binary data to the
+ * touchpad, as it is generally not OK to send arbitrary bytes out the
+ * PS/2 port.  Each of the sequences in this table sends one nibble of the
+ * register address or (write) data.  Different versions of the ALPS protocol
+ * use slightly different encodings.
+ */
 struct alps_nibble_commands {
 	int command;
 	unsigned char data;
 };
 
+/**
+ * struct alps_data - private data structure for the ALPS driver
+ * @dev2: "Relative" device used to report trackstick or mouse activity.
+ * @phys: Physical path for the relative device.
+ * @i: Information on the detected touchpad model.
+ * @nibble_commands: Command mapping used for touchpad register accesses.
+ * @addr_command: Command used to tell the touchpad that a register address
+ *   follows.
+ * @prev_fin: Finger bit from previous packet.
+ * @multi_packet: Multi-packet data in progress.
+ * @multi_data: Saved multi-packet data.
+ * @x1: First X coordinate from last MT report.
+ * @x2: Second X coordinate from last MT report.
+ * @y1: First Y coordinate from last MT report.
+ * @y2: Second Y coordinate from last MT report.
+ * @fingers: Number of fingers from last MT report.
+ * @quirks: Bitmap of ALPS_QUIRK_*.
+ * @timer: Timer for flushing out the final report packet in the stream.
+ */
 struct alps_data {
-	struct input_dev *dev2;		/* Relative device */
-	char phys[32];			/* Phys */
-	const struct alps_model_info *i;/* Info */
+	struct input_dev *dev2;
+	char phys[32];
+	const struct alps_model_info *i;
 	const struct alps_nibble_commands *nibble_commands;
-	int addr_command;		/* Command to set register address */
-	int prev_fin;			/* Finger bit from previous packet */
-	int multi_packet;		/* Multi-packet data in progress */
-	unsigned char multi_data[6];	/* Saved multi-packet data */
-	int x1, x2, y1, y2;		/* Coordinates from last MT report */
-	int fingers;			/* Number of fingers from MT report */
+	int addr_command;
+	int prev_fin;
+	int multi_packet;
+	unsigned char multi_data[6];
+	int x1, x2, y1, y2;
+	int fingers;
 	u8 quirks;
 	struct timer_list timer;
 };
-- 
1.7.10.4

