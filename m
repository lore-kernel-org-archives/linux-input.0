From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 01/22] compal-laptop: Fix leaking hwmon device
Date: Tue, 10 Mar 2015 09:27:05 +0100
Message-ID: <1425976046-20973-2-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36137 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbCJI1t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 04:27:49 -0400
In-reply-to: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.orglinux-
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

The commit c2be45f09bb0 ("compal-laptop: Use
devm_hwmon_device_register_with_groups") wanted to change the
registering of hwmon device to resource-managed version. It mostly did
it except the main thing - it forgot to use devm-like function so the
hwmon device leaked after device removal or probe failure.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: c2be45f09bb0 ("compal-laptop: Use devm_hwmon_device_register_with_groups")
Cc: <stable@vger.kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Darren Hart <dvhart@linux.intel.com>

---
Changes since previous submission:
1. Add Darren's ack.
   http://lkml.iu.edu/hypermail/linux/kernel/1503.0/01895.html
---
 drivers/platform/x86/compal-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 15c0fab2bfa1..eb9885e7fb0e 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1026,9 +1026,9 @@ static int compal_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
-						      "compal", data,
-						      compal_hwmon_groups);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   "compal", data,
+							   compal_hwmon_groups);
 	if (IS_ERR(hwmon_dev)) {
 		err = PTR_ERR(hwmon_dev);
 		goto remove;
-- 
1.9.1

