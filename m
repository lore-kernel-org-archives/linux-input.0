From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Fixed missing inits in hid-cando.c
Date: Fri, 16 Apr 2010 22:23:58 +0200
Message-ID: <20100416202358.7839695164@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:52137 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab0DPUYA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 16:24:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: priya.vijayan@intel.com, floe@butterbrot.org

With flags non initialized, the single touch emulation has an erratic
behavior. Fixed this.

Signed-off-by: Stephane Chatty


diff -rupN a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
--- a/drivers/hid/hid-cando.c	2010-04-16 22:04:20.000000000 +0200
+++ b/drivers/hid/hid-cando.c	2010-04-16 22:02:38.000000000 +0200
@@ -211,6 +211,9 @@ static int cando_probe(struct hid_device
 		return -ENOMEM;
 	}
 	hid_set_drvdata(hdev, td);
+	td->first = false;
+	td->oldest = -1;
+	td->valid = false;
 
 	ret = hid_parse(hdev);
 	if (!ret)
