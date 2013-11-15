From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4 v3] input: wacom - Add support for new Intuos devices
Date: Fri, 15 Nov 2013 11:57:31 -0800
Message-ID: <1384545451-15386-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47831 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3KOT5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 14:57:50 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so2470186pab.37
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 11:57:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net, Ping Cheng <pingc@wacom.com>

This patchset includes 4 outstanding Wacom patches posted in
the last two months. They are based on Dmitry's next branch.

Intuos series support is is its 3rd version. The patchset
has been tested by users at linuxwacom.sf.net. Change history
is listed below.

v2: Change SW_TOUCH_ENABLED to SW_TOUCH and clear BTN_TOUCH bit
for button only interfaces as suggested by Peter Hutterer.

v3: Make "touch hardware switch" into a new patch as suggested
by Chris Bagwell. Change INTUOS_HT to INTUOSHT as Peter suggested.

Added: Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
and    Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
for relevant patches.

Jason's patch is included to avoid missing patch in mailling list.

Jason Gerecke (1):
  input: wacom - Scale up touch width and height values for Intuos Pro

Ping Cheng (3):
  input: wacom - make sure touch_max is set for touch devices
  Input: wacom - add support for three new Intuos devices
  Input: wacom - add SW_TOUCH to include/uapi/linux/input.h

 drivers/input/tablet/wacom_sys.c | 23 ++++++++--
 drivers/input/tablet/wacom_wac.c | 94 ++++++++++++++++++++++++++++++++--------
 drivers/input/tablet/wacom_wac.h |  7 +++
 include/uapi/linux/input.h       |  1 +
 4 files changed, 102 insertions(+), 23 deletions(-)

-- 
1.8.3.2

