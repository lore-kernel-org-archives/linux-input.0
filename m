From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 2/6] Input - soc_button_array: bail out earlier if gpiod_count is null
Date: Fri, 13 May 2016 18:05:50 +0200
Message-ID: <1463155554-11747-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-input@vger.kernel.org

The PNP0C40 device of the Surface 3 doesn't have any GPIO attached to it.
Instead of trying to access the GPIO, request the count beforehand and
bail out if it is null or if an error is returned.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
changes in v2:
- hunk moved down for better integration with later patches

 drivers/input/misc/soc_button_array.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index bbd433c..5467d04 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -167,6 +167,11 @@ static int soc_button_probe(struct platform_device *pdev)
 
 	button_info = (struct soc_button_info *)id->driver_data;
 
+	if (gpiod_count(&pdev->dev, KBUILD_MODNAME) <= 0) {
+		dev_info(&pdev->dev, "no GPIO attached, ignoring...\n");
+		return -ENODEV;
+	}
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.5.0
