From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 02/22] compal-laptop: Check return value of
 power_supply_register
Date: Thu, 12 Mar 2015 08:44:00 +0100
Message-ID: <1426146260-30081-3-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The return value of power_supply_register() call was not checked and
even on error probe() function returned 0. If registering failed then
during unbind the driver tried to unregister power supply which was not
actually registered.

This could lead to memory corruption because power_supply_unregister()
unconditionally cleans up given power supply.

Fix this by checking return status of power_supply_register() call. In
case of failure, clean up sysfs entries and fail the probe.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 9be0fcb5ed46 ("compal-laptop: add JHL90, battery & hwmon interface")
Cc: <stable@vger.kernel.org>

---
Changes since previous submission:
1. Add Darren's ack.
   http://lkml.iu.edu/hypermail/linux/kernel/1503.0/01897.html
---
 drivers/platform/x86/compal-laptop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index eb9885e7fb0e..bceb30b539f3 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1036,7 +1036,9 @@ static int compal_probe(struct platform_device *pdev)
 
 	/* Power supply */
 	initialize_power_supply_data(data);
-	power_supply_register(&compal_device->dev, &data->psy);
+	err = power_supply_register(&compal_device->dev, &data->psy);
+	if (err < 0)
+		goto remove;
 
 	platform_set_drvdata(pdev, data);
 
-- 
1.9.1

