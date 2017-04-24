From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 2/7] HID: sensor-hub: Delete error messages for failed memory
 allocations in sensor_hub_probe()
Date: Mon, 24 Apr 2017 22:17:54 +0200
Message-ID: <7f9e0982-90b9-0e74-4732-7e3153813b2b@users.sourceforge.net>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2d526d72-a740-367b-04a9-ed698435f8ed-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-GB
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Mon, 24 Apr 2017 19:45:25 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: Possible unnecessary 'out of memory' message

Thus remove such statements here.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 349494fc8def..feb4bb8ee3ec 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -640,10 +640,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	struct hid_sensor_hub_device *collection_hsdev = NULL;
 
 	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
-	if (!sd) {
-		hid_err(hdev, "cannot allocate Sensor data\n");
+	if (!sd)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, sd);
 	sd->quirks = id->driver_data;
@@ -678,7 +676,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			       sizeof(*sd->hid_sensor_hub_client_devs),
 			       GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
-		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
 	}
@@ -692,7 +689,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			hsdev = devm_kzalloc(&hdev->dev, sizeof(*hsdev),
 					     GFP_KERNEL);
 			if (!hsdev) {
-				hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
 				ret = -ENOMEM;
 				goto err_stop_hw;
 			}
-- 
2.12.2
