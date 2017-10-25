From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v6 1/6] mfd: mt6397: create irq mappings in mfd core driver
Date: Wed, 25 Oct 2017 21:15:59 +0800
Message-ID: <1508937364-30054-2-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, Beomho Seo <beomho.seo@samsung.com>, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The core driver should create and manage irq mappings instead of
leaf drivers. This patch change to pass irq domain to
devm_mfd_add_devices() and it will create mapping for irq resources
automatically. And remove irq mapping in rtc driver since this has
been done in core driver.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/mfd/mt6397-core.c |    4 ++--
 drivers/rtc/rtc-mt6397.c  |    7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 04a601f..6546d7f 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -289,7 +289,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
 					   ARRAY_SIZE(mt6323_devs), NULL,
-					   0, NULL);
+					   0, pmic->irq_domain);
 		break;
 
 	case MT6397_CID_CODE:
@@ -304,7 +304,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
 					   ARRAY_SIZE(mt6397_devs), NULL,
-					   0, NULL);
+					   0, pmic->irq_domain);
 		break;
 
 	default:
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 1a61fa5..385f830 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -322,10 +322,9 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->addr_base = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
-	if (rtc->irq <= 0)
-		return -EINVAL;
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0)
+		return rtc->irq;
 
 	rtc->regmap = mt6397_chip->regmap;
 	rtc->dev = &pdev->dev;
-- 
1.7.9.5
