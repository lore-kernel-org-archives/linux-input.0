From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/5] Input: turbografx - clear unused function pointers
Date: Tue, 17 Nov 2015 19:10:17 +0530
Message-ID: <1447767619-28329-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

tgfx_parport_cb is a local uninitialized structure and the member
function pointers will be pointing to arbitrary locations unless they
are cleared.

Fixes: 4de27a638a99 ("Input: turbografx - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/turbografx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 9f5bca2..77f575d 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -181,6 +181,7 @@ static void tgfx_attach(struct parport *pp)
 	n_buttons = tgfx_cfg[port_idx].args + 1;
 	n_devs = tgfx_cfg[port_idx].nargs - 1;
 
+	memset(&tgfx_parport_cb, 0, sizeof(tgfx_parport_cb));
 	tgfx_parport_cb.flags = PARPORT_FLAG_EXCL;
 
 	pd = parport_register_dev_model(pp, "turbografx", &tgfx_parport_cb,
-- 
1.9.1
