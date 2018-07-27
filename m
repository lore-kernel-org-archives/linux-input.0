From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: misc: keyspan_remote: Replace GFP_ATOMIC with GFP_KERNEL in keyspan_probe()
Date: Fri, 27 Jul 2018 10:12:58 +0800
Message-ID: <20180727021258.29675-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, arvind.yadav.cs@gmail.com, gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

keyspan_probe() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replace with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/misc/keyspan_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 67482b248b2d..a8937ceac66a 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -466,7 +466,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 	remote->in_endpoint = endpoint;
 	remote->toggle = -1;	/* Set to -1 so we will always not match the toggle from the first remote message. */
 
-	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_ATOMIC, &remote->in_dma);
+	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_KERNEL, &remote->in_dma);
 	if (!remote->in_buffer) {
 		error = -ENOMEM;
 		goto fail1;
-- 
2.17.0
