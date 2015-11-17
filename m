From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/5] Input: walkera0701 - clear unused function pointers
Date: Tue, 17 Nov 2015 19:10:18 +0530
Message-ID: <1447767619-28329-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

walkera0701_parport_cb is a local uninitialized structure and the member
function pointers will be pointing to arbitrary locations unless they
are cleared.

Fixes: 221bcb24c653 ("Input: walkera0701 - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/walkera0701.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index 9c07fe9..70a893a 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -218,6 +218,7 @@ static void walkera0701_attach(struct parport *pp)
 
 	w->parport = pp;
 
+	memset(&walkera0701_parport_cb, 0, sizeof(walkera0701_parport_cb));
 	walkera0701_parport_cb.flags = PARPORT_FLAG_EXCL;
 	walkera0701_parport_cb.irq_func = walkera0701_irq_handler;
 	walkera0701_parport_cb.private = w;
-- 
1.9.1
