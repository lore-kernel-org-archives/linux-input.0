From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 2/2] HID: wacom: Add pad buttons reporting on Intuos4 WL
Date: Tue, 28 Feb 2012 17:19:05 +0000
Message-ID: <1330449545-6217-2-git-send-email-przemo@firszt.eu>
References: <1330449545-6217-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330449545-6217-1-git-send-email-przemo@firszt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com, peter.hutterer@who-t.net
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>
List-Id: linux-input@vger.kernel.org

This patch adds reporting of 1 wheel button and 8 strip buttons for Int=
uos4 WL.
The buttons are reported as BTN_0 to BTN_9. The change of type butstate=
 variable
is required as the old type 'char' couldn't store state of 9 buttons. T=
he change
is not affecting Graphire tablet as it only uses first 2 bits of 'butst=
ate'.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Acked-by=EF=BC=9APing Cheng <pinglinux@gmail.com>
---
 drivers/hid/hid-wacom.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 5a58db2..58aedbc 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -31,9 +31,11 @@
=20
 #include "hid-ids.h"
=20
+#define PAD_DEVICE_ID	0x0F
+
 struct wacom_data {
 	__u16 tool;
-	unsigned char butstate;
+	__u16 butstate;
 	__u8 features;
 	__u32 id;
 	__u32 serial;
@@ -316,6 +318,30 @@ static int wacom_gr_parse_report(struct hid_device=
 *hdev,
 	return 1;
 }
=20
+static void wacom_i4_parse_button_report(struct wacom_data *wdata,
+			struct input_dev *input, unsigned char *data)
+{
+	__u16 new_butstate;
+
+	new_butstate =3D (data[3] << 1) | (data[2] & 0x01);
+	if (new_butstate !=3D wdata->butstate) {
+		wdata->butstate =3D new_butstate;
+		input_report_key(input, BTN_0, new_butstate & 0x001);
+		input_report_key(input, BTN_1, new_butstate & 0x002);
+		input_report_key(input, BTN_2, new_butstate & 0x004);
+		input_report_key(input, BTN_3, new_butstate & 0x008);
+		input_report_key(input, BTN_4, new_butstate & 0x010);
+		input_report_key(input, BTN_5, new_butstate & 0x020);
+		input_report_key(input, BTN_6, new_butstate & 0x040);
+		input_report_key(input, BTN_7, new_butstate & 0x080);
+		input_report_key(input, BTN_8, new_butstate & 0x100);
+		input_report_key(input, BTN_TOOL_FINGER, 1);
+		input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		input_event(input, EV_MSC, MSC_SERIAL, 0xffffffff);
+		input_sync(input);
+	}
+}
+
 static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 			struct input_dev *input, unsigned char *data)
 {
@@ -389,6 +415,7 @@ static void wacom_i4_parse_report(struct hid_device=
 *hdev,
 		wdata->features =3D data[2];
 		break;
 	case 0x0C: /* Button report */
+		wacom_i4_parse_button_report(wdata, input, data);
 		break;
 	default:
 		hid_err(hdev, "Unknown report: %d,%d\n", data[0], data[1]);
@@ -484,6 +511,13 @@ static int wacom_input_mapped(struct hid_device *h=
dev, struct hid_input *hi,
 		break;
 	case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
 		__set_bit(ABS_MISC, input->absbit);
+		__set_bit(BTN_2, input->keybit);
+		__set_bit(BTN_3, input->keybit);
+		__set_bit(BTN_4, input->keybit);
+		__set_bit(BTN_5, input->keybit);
+		__set_bit(BTN_6, input->keybit);
+		__set_bit(BTN_7, input->keybit);
+		__set_bit(BTN_8, input->keybit);
 		input_set_abs_params(input, ABS_X, 0, 40640, 4, 0);
 		input_set_abs_params(input, ABS_Y, 0, 25400, 4, 0);
 		input_set_abs_params(input, ABS_PRESSURE, 0, 2047, 0, 0);
--=20
1.7.6.4
