From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v4 3/4] HID: steam: command to check wireless connection
Date: Wed, 28 Feb 2018 19:43:21 +0100
Message-ID: <20180228184322.29636-4-rodrigorivascosta@gmail.com>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Cameron Gutman <aicommander@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
List-Id: linux-input@vger.kernel.org

The wireless adaptor does not tell if a device is already connected when
steam_probe() is run.
Use a command to request the connection status.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 9e4b1f640bef..894b678685d3 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -114,6 +114,11 @@ static int steam_send_report(struct steam_device *steam,
 	return ret;
 }
 
+static inline int steam_send_report_byte(struct steam_device *steam, u8 cmd)
+{
+	return steam_send_report(steam, &cmd, 1);
+}
+
 static int steam_get_serial(struct steam_device *steam)
 {
 	/*
@@ -135,6 +140,16 @@ static int steam_get_serial(struct steam_device *steam)
 	return 0;
 }
 
+/*
+ * This command requests the wireless adaptor to post an event
+ * with the connection status. Useful if this driver is loaded when
+ * the controller is already connected.
+ */
+static inline int steam_request_conn_status(struct steam_device *steam)
+{
+	return steam_send_report_byte(steam, 0xb4);
+}
+
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
@@ -363,6 +378,7 @@ static int steam_probe(struct hid_device *hdev,
 			goto hid_hw_open_fail;
 		}
 		hid_info(hdev, "Steam wireless receiver connected");
+		steam_request_conn_status(steam);
 	} else {
 		ret = steam_register(steam);
 		if (ret) {
-- 
2.16.2
