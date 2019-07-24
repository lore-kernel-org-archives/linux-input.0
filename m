From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: elantech - mark expected switch fall-through
Date: Wed, 24 Jul 2019 12:52:02 -0500
Message-ID: <20190724175202.GA9583@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/input/mouse/elantech.c: In function 'elantech_use_host_notify':
drivers/input/mouse/elantech.c:1843:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dmi_get_bios_year() >= 2018)
      ^
drivers/input/mouse/elantech.c:1845:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Notice that -Wimplicit-fallthrough will be globally
enabled in v5.3.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 73544776a9ed..04fe43440a3c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1842,6 +1842,7 @@ static bool elantech_use_host_notify(struct psmouse *psmouse,
 		/* SMbus implementation is stable since 2018 */
 		if (dmi_get_bios_year() >= 2018)
 			return true;
+		/* fall through */
 	default:
 		psmouse_dbg(psmouse,
 			    "Ignoring SMBus bus provider %d\n", info->bus);
-- 
2.22.0
