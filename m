From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/3] Input: turbografx - store object in correct index
Date: Fri,  2 Oct 2015 16:58:35 +0530
Message-ID: <1443785315-31495-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

The variable i is used to check the port to attach to and we are
supposed to save the reference of struct tgfx in the location given by
tgfx_base[i]. But after finding out the index i is getting modified again
so we saved in a wrong index.

Fixes: 4de27a638a99 ("Input: turbografx - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/turbografx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 01e8ea9..dc62d58 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -162,7 +162,7 @@ static void tgfx_attach(struct parport *pp)
 	struct tgfx *tgfx;
 	struct input_dev *input_dev;
 	struct pardevice *pd;
-	int i, j;
+	int i, j, k;
 	int *n_buttons, n_devs;
 	struct pardev_cb tgfx_parport_cb;
 
@@ -177,6 +177,7 @@ static void tgfx_attach(struct parport *pp)
 		pr_debug("Not using parport%d.\n", pp->number);
 		return;
 	}
+	k = i;
 	n_buttons = tgfx_cfg[i].args + 1;
 	n_devs = tgfx_cfg[i].nargs - 1;
 
@@ -250,7 +251,7 @@ static void tgfx_attach(struct parport *pp)
 		goto err_free_tgfx;
         }
 
-	tgfx_base[i] = tgfx;
+	tgfx_base[k] = tgfx;
 	return;
 
  err_free_dev:
-- 
1.9.1
