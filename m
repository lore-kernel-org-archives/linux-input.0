From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: wacom - fix a check for WACOM_24HDT
Date: Mon, 29 Oct 2012 11:49:56 +0300
Message-ID: <20121029084956.GA7506@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:19653 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757817Ab2J2IuO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 04:50:14 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The current condition is always true.  From the context, it looks like
we should be checking if ->type == WACOM_24HDT.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 2c1e12b..858ad44 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -391,7 +391,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
 						}
 
-						if (features->type == MTSCREEN || WACOM_24HDT)
+						if (features->type == MTSCREEN || features->type == WACOM_24HDT)
 							features->pktlen = WACOM_PKGLEN_MTOUCH;
 
 						if (features->type == BAMBOO_PT) {
