From: Oliver Neukum <oliver@neukum.org>
Subject: [patch for 2.6.28]open refcount issue in hidraw
Date: Mon, 15 Dec 2008 13:04:45 +0100
Message-ID: <200812151304.45996.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:55324 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYLOMCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2008 07:02:50 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

The hidraw subsystem has a bug that prevents the close syscall from eve=
r
reaching the low level driver, leading to a resource leak. Fix by repla=
cing
postdecrement with predecrement.

Signed-off-by: Oliver Neukum<oneukum@suse.de>

Hi Ji=C5=99i,

I found this testing hid autosuspend, but it is absolutely independent
from it. In fact it seems to me that it should still go into 2.6.28 des=
pite
the lateness and should definitely go into the stable series. Hence
I am sending this as a separate patch.

---

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 7685ae6..96ec1ba 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -208,7 +208,7 @@ static int hidraw_release(struct inode * inode, str=
uct file * file)
=20
 	list_del(&list->node);
 	dev =3D hidraw_table[minor];
-	if (!dev->open--) {
+	if (!--dev->open) {
 		if (list->hidraw->exist)
 			dev->hid->ll_driver->close(dev->hid);
 		else
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
