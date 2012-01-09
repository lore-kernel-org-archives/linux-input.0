From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: [PATCH] Set buttonpad property bit on bcm5974 devices.
Date: Mon,  9 Jan 2012 18:33:46 +0200
Message-ID: <1326126826-11608-1-git-send-email-jussi.pakkanen@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46487 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170Ab2AIQds (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 11:33:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, linux-input@vger.kernel.org

---
 drivers/input/mouse/bcm5974.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..7c69d9e 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -876,6 +876,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 
 	input_dev->name = "bcm5974";
 	input_dev->phys = dev->phys;
+	__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit); 
 	usb_to_input_id(dev->udev, &input_dev->id);
 	/* report driver capabilities via the version field */
 	input_dev->id.version = cfg->caps;
-- 
1.7.5.4

