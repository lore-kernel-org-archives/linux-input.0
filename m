From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v2 0/4] Input: xpad - improve support for new Xbox One S pad
Date: Mon, 15 Aug 2016 21:10:12 -0700
Message-ID: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35133 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcHPEKS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2016 00:10:18 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so4570189pad.2
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2016 21:10:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

This pad generally works well enough on the current xpad, but there are
a few usability issues that I'm fixing with this series.

The notable changes:

The protocol seems to have changed a bit with the new pad. For one, it
needs an ack for the mode report now, otherwise it just retransmits it
forever. This makes the mode button look stuck down to userspace after
the first time it is pressed.

It also seems to overflow some internal buffer, hang, then eventually
reset the pad if there is user input without the driver listening.
This causes a spurious disconnection that may cause userspace programs
to behave unexpectedly.

Changes in v2:
Fixed multi-line comment style in patch 2 and 3 to be consistent with
the existing code. I've also added a simple patch to address rumble
issues on all Xbox One pads, including Xbox One S.

Cameron Gutman (4):
  Input: xpad - add device ID for Xbox One S pad
  Input: xpad - fix One S pad disconnecting when not opened
  Input: xpad - fix stuck mode button on Xbox One S pad
  Input: xpad - fix Xbox One rumble stopping after 2.5 secs

 drivers/input/joystick/xpad.c | 60 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

-- 
2.7.4

