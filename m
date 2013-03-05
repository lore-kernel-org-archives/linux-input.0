From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 4/7] usbnet: cdc_mbim: don't recover device if suspend fails in system sleep
Date: Tue,  5 Mar 2013 12:01:40 +0800
Message-ID: <1362456103-24956-5-git-send-email-ming.lei@canonical.com>
References: <1362456103-24956-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1362456103-24956-1-git-send-email-ming.lei@canonical.com>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
List-Id: linux-input@vger.kernel.org

If suspend callback fails in system sleep context, usb core will
ignore the failure and let system sleep go ahead further, so
this patch doesn't recover device under this situation.

Cc: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/net/usb/cdc_mbim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 248d2dc..da83546 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -338,7 +338,7 @@ static int cdc_mbim_suspend(struct usb_interface *i=
ntf, pm_message_t message)
=20
 	if (intf =3D=3D ctx->control && info->subdriver && info->subdriver->s=
uspend)
 		ret =3D info->subdriver->suspend(intf, message);
-	if (ret < 0)
+	if (ret < 0 && PMSG_IS_AUTO(msg))
 		usbnet_resume(intf);
=20
 error:
--=20
1.7.9.5
