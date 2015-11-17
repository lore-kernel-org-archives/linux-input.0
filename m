From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/5] Input: gamecon - clear unused function pointers
Date: Tue, 17 Nov 2015 19:10:16 +0530
Message-ID: <1447767619-28329-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

gc_parport_cb is a local uninitialized structure and the member
function pointers will be pointing to arbitrary locations unless they
are cleared.

Fixes: a517e87c3dfc ("Input: gamecon - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/gamecon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 5a672dc..eae14d5 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -951,6 +951,7 @@ static void gc_attach(struct parport *pp)
 	pads = gc_cfg[port_idx].args + 1;
 	n_pads = gc_cfg[port_idx].nargs - 1;
 
+	memset(&gc_parport_cb, 0, sizeof(gc_parport_cb));
 	gc_parport_cb.flags = PARPORT_FLAG_EXCL;
 
 	pd = parport_register_dev_model(pp, "gamecon", &gc_parport_cb,
-- 
1.9.1
