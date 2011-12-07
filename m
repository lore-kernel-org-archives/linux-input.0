From: JJ Ding <jj_ding@emc.com.tw>
Subject: [RFC PATCH 0/2] Input: psmouse - new mechanism for bad packet handling
Date: Wed,  7 Dec 2011 19:38:42 +0800
Message-ID: <1323257924-12773-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:15410 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab1LGLkX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 06:40:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>

Hi list,

The first patch adds a new way to deal with bad packets. This mechanism is
used in our original driver. When I first sent the patches to support elan's
v3 and v4 hardware, Dmitry suggested this should be done in psmouse core, so
here is another try.

I am not sure if this is the prefered way to handle bad packets, so I introduce
PSMOUSE_SHIFT_PACKET for psmouse_ret_t, and convert elan driver to use this.

These patches are sent to gather feedback and comments, please take a look, and
let me know if this new mechanism is OK. Thank you very much.

P.S. patches are against Dmitry's -next tree.

Best regards,
-JJ

JJ Ding (2):
  Input: psmouse - work around EC buffer
  Input: elantech - convert v1 ~ v3 hardware to use
    PSMOUSE_SHIFT_PACKET

 drivers/input/mouse/elantech.c     |    6 +++---
 drivers/input/mouse/psmouse-base.c |    5 +++++
 drivers/input/mouse/psmouse.h      |    3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.7.8

