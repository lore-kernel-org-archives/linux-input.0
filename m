From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 22/22] arm: mach-pxa: Decrement the power supply's device
 reference counter
Date: Tue, 10 Mar 2015 09:27:26 +0100
Message-ID: <1425976046-20973-23-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>, Pavel Machek <pavel@ucw.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Use power_supply_put() to decrement the power supply's device reference
counter.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-pxa/raumfeld.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index a762b23ac830..6dc4f025e674 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -758,8 +758,10 @@ static void raumfeld_power_signal_charged(void)
 	struct power_supply *psy =
 		power_supply_get_by_name(raumfeld_power_supplicants[0]);
 
-	if (psy)
+	if (psy) {
 		power_supply_set_battery_charged(psy);
+		power_supply_put(psy);
+	}
 }
 
 static int raumfeld_power_resume(void)
-- 
1.9.1
