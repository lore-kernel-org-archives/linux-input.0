From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 1/7] HID: sensor-hub: Use devm_kcalloc() in sensor_hub_probe()
Date: Mon, 24 Apr 2017 22:16:09 +0200
Message-ID: <8a50aeac-0c9e-fff9-a7e7-61bcd733dfce@users.sourceforge.net>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2d526d72-a740-367b-04a9-ed698435f8ed-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-GB
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Mon, 24 Apr 2017 19:25:29 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ef73374a8f9..349494fc8def 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -672,9 +672,11 @@ static int sensor_hub_probe(struct hid_device *hdev,
 		ret = -EINVAL;
 		goto err_stop_hw;
 	}
-	sd->hid_sensor_hub_client_devs = devm_kzalloc(&hdev->dev, dev_cnt *
-						      sizeof(struct mfd_cell),
-						      GFP_KERNEL);
+	sd->hid_sensor_hub_client_devs
+		= devm_kcalloc(&hdev->dev,
+			       dev_cnt,
+			       sizeof(*sd->hid_sensor_hub_client_devs),
+			       GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
 		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
 		ret = -ENOMEM;
-- 
2.12.2
