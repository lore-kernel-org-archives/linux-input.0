From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: iforce -- add support for ACT LABS forceRS
Date: Mon, 17 Aug 2009 17:20:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908171717510.25797@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbZHQPUm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2009 11:20:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, cmd_ <cemede@gmail.com>, johann.deneux@gmail.com

From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: iforce -- add support for ACT LABS forceRS

Add support for ACT LABS forceRS.

Reported-by: cmd_ <cemede@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 drivers/input/joystick/iforce/iforce-main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index baabf83..da77f4e 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -74,6 +74,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce },
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
+	{ 0x061c, 0xc084, "ACT LABS forceRS",				btn_wheel, abs_wheel, ff_iforce },
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
