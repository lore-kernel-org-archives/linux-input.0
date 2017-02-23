From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] HID: sony: 4.10 fixes
Date: Thu, 23 Feb 2017 15:56:12 -0800
Message-ID: <20170223235613.5112-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36587 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdBWX4S (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 18:56:18 -0500
Received: by mail-pg0-f53.google.com with SMTP id s67so2773269pgb.3
        for <linux-input@vger.kernel.org>; Thu, 23 Feb 2017 15:56:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi,

During testing of patches we are currently working on, we noticed
an input device cleanup issue when connecting a single DS4 using
Bluetooth and USB. This issue leads to memory leaks and in some
conditions likely a crash, so we recommend adding the attached
patch. Long-term we probably want to do 'sony_add' checks earlier
on within sony_input_configured as well to prevent any transient
devices from happening in such situation in the first place, but
this patch at least fixes the cleanup.

Thanks,
Roderick

Roderick Colenbrander (1):
  HID: sony: Fix input device leak when connecting a DS4 twice using
    USB/BT

 drivers/hid/hid-sony.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.9.3

