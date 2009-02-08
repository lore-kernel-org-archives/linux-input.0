From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH] sh: maple: add support for Visual Memory Card devices, and
 make consequential changes to maple input drivers - 0/3 - v5
Date: Sun, 08 Feb 2009 19:41:09 +0000
Message-ID: <1234122069.6736.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: paul mundt <lethal@users.sourceforge.net>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This series of patches adds support for the Dreamcast Visual Memory
Unit, reworking the maple bus code to ensure it supports asynchronous
reads and writes. A consequential amendment to the keyboard and joystick
drivers are also included.

This version (v5) fixes a memory leak in the VMU code that was present
when read or write requests timed out in v4. It also adds the joystick
fix.

The VMU is a 'smart' flash chip where access is controlled by a
microcontroller so that, for instance, flash erases appear to be
transparent to the end user. The VMU does, however, show typical
flash-type behaviour (eg phased writes) and the MTD layer and the chip
work well together (eg in the way they handle apparent hotplug events
during a block write).

This version tidies up some style issues raised with version 2.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---
 drivers/input/joystick/maplecontrol.c |    4 +-
 drivers/input/keyboard/maple_keyb.c   |   40 +-
 drivers/mtd/maps/Kconfig              |   12 +-
 drivers/mtd/maps/Makefile             |    1 +
 drivers/mtd/maps/vmu-flash.c          |  827 +++++++++++++++++++++++++++++++++
 drivers/sh/maple/maple.c              |  463 ++++++++++---------
 include/linux/maple.h                 |   62 ++-
 7 files changed, 1142 insertions(+), 267 deletions(-)


