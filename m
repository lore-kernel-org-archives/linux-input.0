From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 3/6] mfd: max8997: Change irq names to upper case
Date: Wed, 01 Jun 2016 11:53:58 +0200
Message-ID: <1464774841-1439-3-git-send-email-k.kozlowski@samsung.com>
References: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDKZNNNLXAHBBVXBXK5AKGQE7IZOJII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-reply-to: <1464774841-1439-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
In-reply-to: <1464773339-756-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
References: <1464773339-756-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch changes naming convention of MUIC interrupts form CamelCase
to upper case. It makes names more readable and consistent with another
interrupt names in max8997 driver.

Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

[For the mfd part]
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
[k.kozlowski: Collect acks, rebase on v4.6-rc6]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/extcon/extcon-max8997.c     | 32 ++++++++++++++++----------------
 include/linux/mfd/max8997-private.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9d27cc23038f..68754ac2c8ea 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -46,15 +46,15 @@ struct max8997_muic_irq {
 };
 
 static struct max8997_muic_irq muic_irqs[] = {
-	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
-	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
-	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
-	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
-	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
-	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
-	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
-	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
-	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
+	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
+	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
+	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
+	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
+	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
+	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
+	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
+	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
+	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
 };
 
 /* Define supported cable type */
@@ -540,17 +540,17 @@ static void max8997_muic_irq_work(struct work_struct *work)
 	}
 
 	switch (irq_type) {
-	case MAX8997_MUICIRQ_ADCError:
-	case MAX8997_MUICIRQ_ADCLow:
+	case MAX8997_MUICIRQ_ADCERROR:
+	case MAX8997_MUICIRQ_ADCLOW:
 	case MAX8997_MUICIRQ_ADC:
 		/* Handle all of cable except for charger cable */
 		ret = max8997_muic_adc_handler(info);
 		break;
-	case MAX8997_MUICIRQ_VBVolt:
-	case MAX8997_MUICIRQ_DBChg:
-	case MAX8997_MUICIRQ_DCDTmr:
-	case MAX8997_MUICIRQ_ChgDetRun:
-	case MAX8997_MUICIRQ_ChgTyp:
+	case MAX8997_MUICIRQ_VBVOLT:
+	case MAX8997_MUICIRQ_DBCHG:
+	case MAX8997_MUICIRQ_DCDTMR:
+	case MAX8997_MUICIRQ_CHGDETRUN:
+	case MAX8997_MUICIRQ_CHGTYP:
 		/* Handle charger cable */
 		ret = max8997_muic_chg_handler(info);
 		break;
diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8997-private.h
index f42ea222988f..2817fa69383e 100644
--- a/include/linux/mfd/max8997-private.h
+++ b/include/linux/mfd/max8997-private.h
@@ -411,14 +411,14 @@ enum max8997_irq {
 
 enum max8997_irq_muic {
 	MAX8997_MUICIRQ_ADC,
-	MAX8997_MUICIRQ_ADCLow,
-	MAX8997_MUICIRQ_ADCError,
-
-	MAX8997_MUICIRQ_ChgTyp,
-	MAX8997_MUICIRQ_ChgDetRun,
-	MAX8997_MUICIRQ_DCDTmr,
-	MAX8997_MUICIRQ_DBChg,
-	MAX8997_MUICIRQ_VBVolt,
+	MAX8997_MUICIRQ_ADCLOW,
+	MAX8997_MUICIRQ_ADCERROR,
+
+	MAX8997_MUICIRQ_CHGTYP,
+	MAX8997_MUICIRQ_CHGDETRUN,
+	MAX8997_MUICIRQ_DCDTMR,
+	MAX8997_MUICIRQ_DBCHG,
+	MAX8997_MUICIRQ_VBVOLT,
 
 	MAX8997_MUICIRQ_OVP,
 
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
