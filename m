From: Roman Volkov <v1ron@v1ros.org>
Subject: [PATCH v3 3/5] i8042: Add OF match table
Date: Mon, 16 Feb 2015 00:11:45 +0300
Message-ID: <1424034707-15723-4-git-send-email-v1ron@v1ros.org>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
 <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roman Volkov <v1ron@v1ros.org>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-input@vger.kernel.org

The OF device table allows the platform_driver_probe() function to
automatically match device and parse the DT node.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Roman Volkov <v1ron@v1ros.org>
---
 drivers/input/serio/i8042.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 986a71c..2f09062 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1474,12 +1474,22 @@ static int i8042_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef SERIO_I8042_DT
+static struct of_device_id i8042_dt_ids[] = {
+	{ .compatible = "intel,8042" },
+	{ /* Sentinel */ },
+};
+#endif
+
 static struct platform_driver i8042_driver = {
 	.driver		= {
 		.name	= "i8042",
 #ifdef CONFIG_PM
 		.pm	= &i8042_pm_ops,
 #endif
+#ifdef SERIO_I8042_DT
+		.of_match_table = i8042_dt_ids,
+#endif
 	},
 	.remove		= i8042_remove,
 	.shutdown	= i8042_shutdown,
-- 
2.3.0
