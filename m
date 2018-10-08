From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: cyapa - mark expected switch fall-throughs
Date: Mon, 8 Oct 2018 17:38:24 +0200
Message-ID: <20181008153824.GA14336@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the "Fallthrough state"
commern with a proper "Fall through", which is what GCC is expecting to
find.

Addresses-Coverity-ID: 114758 ("Missing break in switch")
Addresses-Coverity-ID: 114759 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/mouse/cyapa_gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 076dda4..00e395d 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -1067,7 +1067,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
 			return error;
 		}
 
-	/* Fallthrough state */
+	/* Fall through */
 	case CYAPA_STATE_BL_IDLE:
 		/* Try to get firmware version in bootloader mode. */
 		cyapa_gen3_bl_query_data(cyapa);
@@ -1078,7 +1078,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
 			return error;
 		}
 
-	/* Fallthrough state */
+	/* Fall through */
 	case CYAPA_STATE_OP:
 		/*
 		 * Reading query data before going back to the full mode
-- 
2.7.4
