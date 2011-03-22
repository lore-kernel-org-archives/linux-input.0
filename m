From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] G25_support
Date: Mon, 21 Mar 2011 22:57:00 -0600
Message-ID: <1300769820-16198-1-git-send-email-simon@mungewell.org>
References: <1299842104.2550.24.camel@slim-one-desktop>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:61396 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab1CVE5S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 00:57:18 -0400
In-Reply-To: <1299842104.2550.24.camel@slim-one-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Peter <peter@slim-one.de>, Simon Wood <simon@mungewell.org>

From: Peter <peter@slim-one.de>

Small patch to add support for the G25/G27 by adding USB ID's
as suggested by Peter.

Boots but otherwise untested as I don't have hardware, .debs for
kernel (2.6.38) here if want to test/run Ubuntu/Debian:
http://www.mungewell.org/Logitech_Wii_Wheel/

Reported-by: Peter <peter@slim-one.de>
Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lgff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index 90d0ef2..f099079 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -73,6 +73,8 @@ static const struct dev_type devices[] = {
 	{ 0x046d, 0xc293, ff_joystick },
 	{ 0x046d, 0xc294, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
+	{ 0x046d, 0xc298, ff_wheel },
+	{ 0x046d, 0xc299, ff_wheel },
 	{ 0x046d, 0xca03, ff_wheel },
 };
 
-- 
1.7.0.4

