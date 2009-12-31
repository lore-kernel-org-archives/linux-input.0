From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] Input: &&/|| confusion in gf2k_connect()?
Date: Thu, 31 Dec 2009 13:19:43 +0100
Message-ID: <4B3C96DF.8060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:1078 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbZLaMQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Dec 2009 07:16:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

This always evaluates to true.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/input/joystick/gf2k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I am not 100% certain, but wasn't this intended?

diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 67c207f..45ac70e 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -277,7 +277,7 @@ static int gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
 	}
 
 #ifdef RESET_WORKS
-	if ((gf2k->id != (GB(19,2,0) | GB(15,3,2) | GB(12,3,5))) ||
+	if ((gf2k->id != (GB(19,2,0) | GB(15,3,2) | GB(12,3,5))) &&
 	    (gf2k->id != (GB(31,2,0) | GB(27,3,2) | GB(24,3,5)))) {
 		err = -ENODEV;
 		goto fail2;
