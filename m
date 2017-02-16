From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/3] Bind RMI4 over SMBus from PS/2
Date: Thu, 16 Feb 2017 18:50:57 +0100
Message-ID: <20170216175100.1668-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932338AbdBPRvF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 12:51:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry,

quoting your last email about this topic:

> I think that by trying to "unwind" unsuccessful SMbus initialization you
> make the code much more complicated and fragile. I think we should
> select a path (PS/2 or SMbus) and commit to it. If we commit to SMBus
> then we need to communicate that fact to psmouse core so that it does
> not create input devices or psmouse attributes, and "short-circuit" the
> reconnect() routines to simply ignore requests and always report
> success.

I have tried in the past to unwind the psmouse input devices, and it was a pain.
So I thought of using a dummy serio driver that basically just calls
PSMOUSE_CMD_DISABLE at connect and returns 0 everywhere else.

I tried this in the past without much luck but I think I found a reliable
way today.

The good thing is that it seems that in that case, the rmi4_smbus driver
doesn't need any changes now that most serio states are ignored.

The new ps2smbus driver gets a little bit more complex, especially because
of kseriod. We need to wait for the .connect() of the serio driver to end
and have a stable PS/2 connection before starting the smbus work.

>From the tests I made today, it seems reliable: cold boot & suspend/resume
works, various "rescan" with drvctl with different synaptics_intertouch
parameter state work too.

I hope you'll find this solution acceptable.

Cheers,
Benjamin

Benjamin Tissoires (3):
  input: serio - allow others to specify a driver for a serio device
  Input: synaptics - allocate a Synaptics Intertouch device
  Input: add a PS/2 to SMBus platform module

 drivers/input/misc/Kconfig      |  11 ++
 drivers/input/misc/Makefile     |   1 +
 drivers/input/misc/ps2_smbus.c  | 382 ++++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.c | 106 +++++++++++
 drivers/input/mouse/synaptics.h |   1 +
 drivers/input/rmi4/Kconfig      |   1 +
 drivers/input/serio/serio.c     |  20 +++
 include/linux/serio.h           |   5 +
 8 files changed, 527 insertions(+)
 create mode 100644 drivers/input/misc/ps2_smbus.c

-- 
2.9.3

