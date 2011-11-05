From: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
Subject: [PATCH 1/2] HID: wacom: Move parsing to a
	separate function
Date: Sat,  5 Nov 2011 11:28:21 +0000
Message-ID: <1320492502-11976-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxwacom-devel>
List-Post: <mailto:linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

This patch doesn't change the way driver works. Parsing logic is now in a
separate function. It's a first step to add Intuos4 Wireless support to
hid-wacom driver.

Signed-off-by: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
Acked-by: Ping Cheng <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Chris Bagwell <chris-ZCD0YumhXB+iMFqZbmIluw@public.gmane.org>
---
 drivers/hid/hid-wacom.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 17bb88f..db23223 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -177,26 +177,13 @@ static ssize_t wacom_store_speed(struct device *dev,
 static DEVICE_ATTR(speed, S_IRUGO | S_IWUSR | S_IWGRP,
 		wacom_show_speed, wacom_store_speed);
 
-static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
-		u8 *raw_data, int size)
+static int wacom_gr_parse_report(struct hid_device *hdev,
+			struct wacom_data *wdata,
+			struct input_dev *input, unsigned char *data)
 {
-	struct wacom_data *wdata = hid_get_drvdata(hdev);
-	struct hid_input *hidinput;
-	struct input_dev *input;
-	unsigned char *data = (unsigned char *) raw_data;
 	int tool, x, y, rw;
 
-	if (!(hdev->claimed & HID_CLAIMED_INPUT))
-		return 0;
-
 	tool = 0;
-	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
-	input = hidinput->input;
-
-	/* Check if this is a tablet report */
-	if (data[0] != 0x03)
-		return 0;
-
 	/* Get X & Y positions */
 	x = le16_to_cpu(*(__le16 *) &data[2]);
 	y = le16_to_cpu(*(__le16 *) &data[4]);
@@ -303,6 +290,26 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 #endif
 	return 1;
 }
+static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *raw_data, int size)
+{
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
+	struct hid_input *hidinput;
+	struct input_dev *input;
+	unsigned char *data = (unsigned char *) raw_data;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		return 0;
+
+	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
+	input = hidinput->input;
+
+	/* Check if this is a tablet report */
+	if (data[0] != 0x03)
+		return 0;
+
+	return wacom_gr_parse_report(hdev, wdata, input, data);
+}
 
 static int wacom_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 	struct hid_field *field, struct hid_usage *usage, unsigned long **bit,
-- 
1.7.6.4


------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
