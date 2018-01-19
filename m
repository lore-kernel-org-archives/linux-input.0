From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/7] psmouse assorted cleanups
Date: Fri, 19 Jan 2018 15:06:22 -0800
Message-ID: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46946 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeASXGd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Just a few cleanups to psmouse code: BIT(), sign_extend(), u8 for data,
etc. Plus a patch from Stephen Lyons to handle A4Tech mice with 2 scroll
wheels.

Thanks.

Dmitry Torokhov (6):
  Input: psmouse - create helper for reporting standard buttons/motion
  Input: psmouse - clean up code
  Input: logips2pp - clean up code
  Input: lifebook - clean up code
  Input: synaptics - switch to using input_set_capability
  Input: synaptics - handle errors from input_mt_init_slots()

Stephen Lyons (1):
  Input: psmouse - add support for 2nd wheel on A4Tech Dual-Scroll wheel
    mice

 drivers/input/mouse/alps.c         |  30 ++----
 drivers/input/mouse/elantech.c     |  28 ++----
 drivers/input/mouse/lifebook.c     |  62 +++++++------
 drivers/input/mouse/logips2pp.c    | 152 ++++++++++++++++++-------------
 drivers/input/mouse/psmouse-base.c | 181 +++++++++++++++++++++++--------------
 drivers/input/mouse/psmouse.h      |   4 +
 drivers/input/mouse/sentelic.c     |  11 +--
 drivers/input/mouse/synaptics.c    |  82 ++++++++++-------
 8 files changed, 302 insertions(+), 248 deletions(-)

-- 
Dmitry
