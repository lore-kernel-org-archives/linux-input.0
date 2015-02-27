From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v5 16/20] x86/olpc/xo15/sci: Use newly added power_supply_put
 API
Date: Fri, 27 Feb 2015 09:19:57 +0100
Message-ID: <1425025201-15926-17-git-send-email-k.kozlowski@samsung.com>
References: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Replace direct usage of put_device() with new API: power_supply_put().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 186634e9021d..55130846ac87 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -83,7 +83,7 @@ static void battery_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(&psy->dev);
+		power_supply_put(psy);
 	}
 }
 
@@ -93,7 +93,7 @@ static void ac_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(&psy->dev);
+		power_supply_put(psy);
 	}
 }
 
-- 
1.9.1
