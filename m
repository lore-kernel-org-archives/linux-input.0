From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] psmouse: fix up Synaptics comment
Date: Fri, 17 Dec 2010 21:09:05 -0800
Message-ID: <20101217210905.334329bc@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Minor comment fixup for typos and grammar.  Noticed while adding a separate
workaround.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/input/mouse/synaptics.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 75fbf33..10e8612 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -832,8 +832,8 @@ int synaptics_init(struct psmouse *psmouse)
 
 	/*
 	 * Toshiba's KBC seems to have trouble handling data from
-	 * Synaptics as full rate, switch to lower rate which is roughly
-	 * thye same as rate of standard PS/2 mouse.
+	 * Synaptics at full rate.  Switch to a lower rate (roughly
+	 * the same rate as a standard PS/2 mouse).
 	 */
 	if (psmouse->rate >= 80 && impaired_toshiba_kbc) {
 		printk(KERN_INFO "synaptics: Toshiba %s detected, limiting rate to 40pps.\n",
-- 
1.7.2.3
