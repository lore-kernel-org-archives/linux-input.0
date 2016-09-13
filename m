From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] Fix spurious joydev node on some unrelated devices
Date: Tue, 13 Sep 2016 11:52:36 +0200
Message-ID: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755796AbcIMJwm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 05:52:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

It looks like Steam is suffering from having spurious joydev nodes not
properly handled by the kernel. This appears on nearly all Microsoft devices
and all Wacom tablets (though I guess the interference between Wacom tablet
and Steam is not much of a problem :-P ).

Anyway, this should fix a long standing issue (since 2011 apparently).

It's still unclear whether this will fix all the spurious joydev nodes for
other vendors too (A4Tech mice notably).

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: input: ignore System Control application usages if not System
    Controls
  HID: wacom: do not detect Pad devices as joysticks

 drivers/hid/hid-input.c | 9 +++++++++
 drivers/hid/wacom_wac.c | 3 +++
 2 files changed, 12 insertions(+)

-- 
2.7.4

