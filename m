From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH 0/2] Support more Mayflash game contoller adapters.
Date: Sat, 7 Jan 2017 12:09:26 +0100
Message-ID: <20170107110926.GA14173@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33573 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031972AbdAGLJd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 7 Jan 2017 06:09:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id r144so1633092wme.0
        for <linux-input@vger.kernel.org>; Sat, 07 Jan 2017 03:09:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Robert de Rooy <robert.de.rooy@gmail.com>

This patchset improves support for the Mayflash DolphinBar and GameCube adapters. These have been tested by Robert de Rooy and confirmed to work correctly using the following patches. See Bugzilla entry 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841) for more information.

Marcel Hasler (2):
  hid: Add a new device ID for updated Mayflash/Dragonrise GameCube adapter.
  hid-mf: Add force feedback support for Mayflash DolphinBar and GameCube adapters.

 drivers/hid/hid-core.c          |  3 +++
 drivers/hid/hid-ids.h           |  3 ++-
 drivers/hid/hid-mf.c            | 19 ++++++++++++++-----
 drivers/hid/usbhid/hid-quirks.c |  2 +-
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.11.0

