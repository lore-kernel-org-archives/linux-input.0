From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH] Input: tegra-kbc: fix inverted reset logic
Date: Tue, 16 Aug 2016 11:59:23 +0900
Message-ID: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Commit fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
accidentally converted _deassert to _assert, so there is no code
to wake up this hardware.

Fixes: fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

 drivers/input/keyboard/tegra-kbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 7d61439..0c07e10 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -376,7 +376,7 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
 	/* Reset the KBC controller to clear all previous status.*/
 	reset_control_assert(kbc->rst);
 	udelay(100);
-	reset_control_assert(kbc->rst);
+	reset_control_deassert(kbc->rst);
 	udelay(100);
 
 	tegra_kbc_config_pins(kbc);
-- 
1.9.1
