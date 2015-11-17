From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/5] Input: db9 - clear unused function pointers
Date: Tue, 17 Nov 2015 19:10:15 +0530
Message-ID: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

db9_parport_cb is a local uninitialized structure and the member
function pointers will be pointing to arbitrary locations unless they
are cleared.

Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/joystick/db9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index 932d073..da32609 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -592,6 +592,7 @@ static void db9_attach(struct parport *pp)
 		return;
 	}
 
+	memset(&db9_parport_cb, 0, sizeof(db9_parport_cb));
 	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
 
 	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, port_idx);
-- 
1.9.1
