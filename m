From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Sat, 27 Mar 2010 13:51:51 -0400
Message-ID: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57713 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0C0Rvz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Mar 2010 13:51:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested by a user running Ubuntu 9.10 in the following bug report.

BugLink: http://bugs.launchpad.net/bugs/545307

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Cc: stable@kernel.org
---
 drivers/input/mouse/alps.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f93c2c0..432e3ef 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -63,6 +63,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
+	{ { 0x73, 0x02, 0x64 }, 0xf8, 0xf8, 0 },			  /* HP Pavilion dm3 */
 };
 
 /*
-- 
1.7.0

