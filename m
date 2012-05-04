From: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
Subject: [PATCH] HID: wacom: Add tilt reporting for
	Intuos4 WL
Date: Fri,  4 May 2012 18:00:10 +0100
Message-ID: <1336150810-17390-1-git-send-email-przemo@firszt.eu>
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
To: pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Tile is reported to input subsystem as reported by the device without
any modifications. It means that tilt X/Y range is 0 to 127 and it's
not centered on zero.

Signed-off-by: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
---
 drivers/hid/hid-wacom.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index fb0fe16..a66e1aa 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -363,6 +363,7 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 {
 	__u16 x, y, pressure;
 	__u8 distance;
+	__u8 tilt_x, tilt_y;
 
 	switch (data[1]) {
 	case 0x80: /* Out of proximity report */
@@ -399,6 +400,8 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 		pressure = (data[6] << 3) | ((data[7] & 0xC0) >> 5)
 			| (data[1] & 0x01);
 		distance = (data[9] >> 2) & 0x3f;
+		tilt_x = ((data[7] << 1) & 0x7e) | (data[8] >> 7);
+		tilt_y = data[8] & 0x7f;
 
 		input_report_key(input, BTN_TOUCH, pressure > 1);
 
@@ -409,6 +412,8 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 		input_report_abs(input, ABS_Y, y);
 		input_report_abs(input, ABS_PRESSURE, pressure);
 		input_report_abs(input, ABS_DISTANCE, distance);
+		input_report_abs(input, ABS_TILT_X, tilt_x);
+		input_report_abs(input, ABS_TILT_Y, tilt_y);
 		input_report_abs(input, ABS_MISC, wdata->id);
 		input_event(input, EV_MSC, MSC_SERIAL, wdata->serial);
 		input_report_key(input, wdata->tool, 1);
@@ -548,6 +553,8 @@ static int wacom_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		input_set_abs_params(input, ABS_Y, 0, 25400, 4, 0);
 		input_set_abs_params(input, ABS_PRESSURE, 0, 2047, 0, 0);
 		input_set_abs_params(input, ABS_DISTANCE, 0, 63, 0, 0);
+		input_set_abs_params(input, ABS_TILT_X, 0, 127, 0, 0);
+		input_set_abs_params(input, ABS_TILT_Y, 0, 127, 0, 0);
 		break;
 	}
 
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
