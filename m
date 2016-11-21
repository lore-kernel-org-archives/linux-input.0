From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] HID: fix few non-DMA capable HID transfers
Date: Mon, 21 Nov 2016 11:48:38 +0100
Message-ID: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26771 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753599AbcKUKsq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Nov 2016 05:48:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

While playing a little bit with the CP2112 (for hid-rmi I must confess), I
realized that kernel v4.9 now enforces DMA capable buffers when calling
hid_hw_raw_request(). Kernel v4.8 works fine (but gives a stacktrace the first
time), but v4.9 doesn't.

So I gave a check of all the other drivers in the HID tree, and it looks like
only 4 drivers are not properly allocating their buffers.

I'd say this is v4.9 material but I was not able to test magicmouse and lg.
If this doesn't qualifies for 4.9-rc7, I think we should add the stable@ stamp,
given that the chance this will break hid-rmi is huge (cp2112 is not so much an
issue, given it's a devel board).

Cheers,
Benjamin



Benjamin Tissoires (4):
  HID: cp2112: make transfer buffers DMA capable
  HID: lg: make transfer buffers DMA capable
  HID: magicmouse: make transfer buffers DMA capable
  HID: rmi: make transfer buffers DMA capable

 drivers/hid/hid-cp2112.c     | 115 +++++++++++++++++++++++++++++--------------
 drivers/hid/hid-lg.c         |  12 +++--
 drivers/hid/hid-magicmouse.c |  12 ++++-
 drivers/hid/hid-rmi.c        |  10 +++-
 4 files changed, 106 insertions(+), 43 deletions(-)

-- 
2.7.4

