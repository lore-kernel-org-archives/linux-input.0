From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/5] Input: parkbd - clear unused function pointers
Date: Tue, 17 Nov 2015 19:10:19 +0530
Message-ID: <1447767619-28329-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

parkbd_parport_cb is a local uninitialized structure and the member
function pointers will be pointing to arbitrary locations unless they
are cleared.

Fixes: 33ca8ab97cbb ("Input: parkbd - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/serio/parkbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 92c31b8..1edfac7 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -145,6 +145,7 @@ static int parkbd_getport(struct parport *pp)
 {
 	struct pardev_cb parkbd_parport_cb;
 
+	memset(&parkbd_parport_cb, 0, sizeof(parkbd_parport_cb));
 	parkbd_parport_cb.irq_func = parkbd_interrupt;
 	parkbd_parport_cb.flags = PARPORT_FLAG_EXCL;
 
-- 
1.9.1
