From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/10] pwm: add push-pull mode support
Date: Thu, 22 Feb 2018 14:01:19 +0200
Message-ID: <1519300881-8136-9-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, shc_work@mail.ru, kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com, linux@roeck-us.net, dmitry.torokhov@gmail.com, rpurdie@rpsys.net, jacek.anaszewski@gmail.com, pavel@ucw.cz, mchehab@kernel.org, sean@mess.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, milo.kim@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/pwm.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ba416ab2772..765d760ef82d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,11 +29,14 @@ enum pwm_polarity {
  * PWM modes
  * @PWM_MODE_NORMAL_BIT: PWM has one output
  * @PWM_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_PUSH_PULL_BIT: PWM has 2 outputs with same polarities and the edges
+ * are complementary delayed for one period
  * @PWM_MODE_CNT: PWM modes count
  */
 enum {
 	PWM_MODE_NORMAL_BIT,
 	PWM_MODE_COMPLEMENTARY_BIT,
+	PWM_MODE_PUSH_PULL_BIT,
 	PWM_MODE_CNT,
 };
 
@@ -481,7 +484,11 @@ static inline bool pwm_caps_valid(struct pwm_caps caps)
 
 static inline const char * const pwm_mode_desc(unsigned long mode)
 {
-	static const char * const modes[] = { "normal", "complementary"	};
+	static const char * const modes[] = {
+		"normal",
+		"complementary",
+		"push-pull",
+	};
 
 	if (!pwm_mode_valid(mode))
 		return "invalid";
-- 
2.7.4
