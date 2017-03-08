From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/3] Bind RMI4 over SMBus from PS/2
Date: Wed,  8 Mar 2017 16:24:42 +0100
Message-ID: <20170308152445.12082-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

This is mostly a resend of the PS/2-SMBus binding (last 3 patches of now 3 years
of trial and errors).
I integrated both warnings raised by Coccinelle, and squashed 4/3 into 3/3.

I really would like your opinion on this solution. If we could have a full
cycle in linux-next that would be ideal too :)

Cheers,
Benjamin

Benjamin Tissoires (3):
  input: serio - allow others to specify a driver for a serio device
  Input: synaptics - allocate a Synaptics Intertouch device
  Input: add a PS/2 to SMBus platform module

 drivers/input/misc/Kconfig      |  11 ++
 drivers/input/misc/Makefile     |   1 +
 drivers/input/misc/ps2_smbus.c  | 424 ++++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.c | 103 ++++++++++
 drivers/input/mouse/synaptics.h |   1 +
 drivers/input/serio/serio.c     |  20 ++
 include/linux/serio.h           |   5 +
 7 files changed, 565 insertions(+)
 create mode 100644 drivers/input/misc/ps2_smbus.c

-- 
2.9.3
