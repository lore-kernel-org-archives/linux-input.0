From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/3] Input: gamecon - store object at correct index
Date: Fri,  2 Oct 2015 16:58:34 +0530
Message-ID: <1443785315-31495-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-input@vger.kernel.org

The variable i is used to check the port to attach to and we are
supposed to save the reference of struct gc in the location given by
gc_base[i]. But after finding out the index i is getting modified again
so we saved in a wrong index.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: a517e87c3dfc ("Input: gamecon - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/gamecon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 394ccbe..0f1f1c4 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -931,7 +931,7 @@ static void gc_attach(struct parport *pp)
 {
 	struct gc *gc;
 	struct pardevice *pd;
-	int i;
+	int i, j;
 	int count = 0;
 	int *pads, n_pads;
 	struct pardev_cb gc_parport_cb;
@@ -948,6 +948,7 @@ static void gc_attach(struct parport *pp)
 		pr_debug("Not using parport%d.\n", pp->number);
 		return;
 	}
+	j = i;
 	pads = gc_cfg[i].args + 1;
 	n_pads = gc_cfg[i].nargs - 1;
 
@@ -985,7 +986,7 @@ static void gc_attach(struct parport *pp)
 		goto err_free_gc;
 	}
 
-	gc_base[i] = gc;
+	gc_base[j] = gc;
 	return;
 
  err_unreg_devs:
-- 
1.9.1
