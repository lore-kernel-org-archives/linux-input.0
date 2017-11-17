From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 05/10] Input: cpcap-pwrbutton: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 00:45:27 +0530
Message-ID: <1510946132-13554-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/cpcap-pwrbutton.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
index 0abef63..a4962e7 100644
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -57,6 +57,9 @@ static int cpcap_power_button_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
+	if (irq < 0)
+		return -ENODEV;
+
 	button = devm_kmalloc(&pdev->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.7.4
