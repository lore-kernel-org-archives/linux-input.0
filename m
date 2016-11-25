From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v3 0/2] Input: xpad - improve support for new Xbox One S pad
Date: Fri, 25 Nov 2016 14:18:33 -0800
Message-ID: <cover.1480111549.git.aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34974 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcKYWTZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 17:19:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so6461493pga.2
        for <linux-input@vger.kernel.org>; Fri, 25 Nov 2016 14:18:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

This is another version of my Xbox One S support improvement series. Early this
month, Microsoft released a firmware update that fixed the pad disconnect and
stuck mode button issues. This considerably simplifies this patch series.

As a result, I've removed these patches from the series:

  [PATCH v2 2/4] Input: xpad - fix One S pad disconnecting when not opened
  [PATCH v2 3/4] Input: xpad - fix stuck mode button on Xbox One S pad

It's up for debate whether the 2 removed patches from v2 should still be merged
to support older firmware, but for now I'm sticking to the simple patches still
useful on the latest firmware.

The rumble fix affects both Xbox One S and all previous Xbox One pads.

Cameron Gutman (2):
  Input: xpad - add product ID for Xbox One S pad
  Input: xpad - fix Xbox One rumble stopping after 2.5 secs

 drivers/input/joystick/xpad.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.9.3

