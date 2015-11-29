From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/6] Only probe select protocols on pass through PS/2 prots
Date: Sat, 28 Nov 2015 21:13:50 -0800
Message-ID: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35027 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbK2FOA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 00:14:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org

This series limits protocols that we probe on pass-through PS/2 ports to
IBM Trackpoint, Intellimouse, Intellimouse Explorer and basic PS/2, since
we have not seen anything else and probing all possible protocols takes too
long.

  Input: psmouse - use switch statement in psmouse_process_byte()
  Input: psmouse - fix comment style
  Input: psmouse - rearrange Focaltech init code
  Input: psmouse - move protocol descriptions around
  Input: psmouse - factor out common protocol probing code
  Input: psmouse - limit protocols that we try on passthrough ports

 drivers/input/mouse/focaltech.c    |  22 +-
 drivers/input/mouse/focaltech.h    |   8 +
 drivers/input/mouse/psmouse-base.c | 769 ++++++++++++++++++-------------------
 3 files changed, 389 insertions(+), 410 deletions(-)

Thanks.

-- 
Dmitry
