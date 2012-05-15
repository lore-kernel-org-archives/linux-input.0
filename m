From: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
Subject: [PATCH 2/3] HID: wacom: Add speed setting for
	Intuos4 WL
Date: Tue, 15 May 2012 19:32:26 +0100
Message-ID: <1337106748-28437-2-git-send-email-przemo@firszt.eu>
References: <1337106748-28437-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337106748-28437-1-git-send-email-przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxwacom-devel>
List-Post: <mailto:linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add option to change reporting speed for Intuos4 WL. The option is only
internal to the module, but it will be extended to allow control over sysfs,
as it is already implemented for Graphire.

Signed-off-by: Przemo Firszt <przemo-q9SP4D9nreWHXe+LvDLADg@public.gmane.org>
---
 drivers/hid/hid-wacom.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 4fc4eeb..5f6ce70 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -228,16 +228,25 @@ static int wacom_ac_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static void wacom_set_features(struct hid_device *hdev)
+static void wacom_set_features(struct hid_device *hdev, u8 speed)
 {
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
 	int ret;
 	__u8 rep_data[2];
 
-	/*set high speed, tablet mode*/
+	if (speed == 1)
+		wdata->features &= ~0x20;
+	else
+		wdata->features |= 0x20;
+
 	rep_data[0] = 0x03;
-	rep_data[1] = 0x20;
+	rep_data[1] = wdata->features;
+
 	ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
 				HID_FEATURE_REPORT);
+	if (ret >= 0)
+		wdata->high_speed = speed;
+
 	return;
 }
 
@@ -719,7 +728,7 @@ static int wacom_probe(struct hid_device *hdev,
 	case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
 		sprintf(hdev->name, "%s", "Wacom Intuos4 WL");
 		wdata->features = 0;
-		wacom_set_features(hdev);
+		wacom_set_features(hdev, 1);
 		ret = wacom_initialize_leds(hdev);
 		if (ret) {
 			hid_warn(hdev,
-- 
1.7.10.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
