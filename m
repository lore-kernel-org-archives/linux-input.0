From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH] sh: maple: Add support for VMU devices (v4) [0/3]
Date: Tue, 03 Feb 2009 16:59:43 +0000
Message-ID: <1233680383.20790.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:8289 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752256AbZBCRBZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Feb 2009 12:01:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg KH <greg@kroah.com>, Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

This series of patches adds support for the Dreamcast Visual Memory
Unit, reworking the maple bus code to ensure it supports asynchronous
reads and writes. A consequential amendment to the keyboard driver is
also included.

The VMU is a 'smart' flash chip where access is controlled by a
microcontroller so that, for instance, flash erases appear to be
transparent to the end user. The VMU does, however, show typical
flash-type behaviour (eg phased writes) and the MTD layer and the chip
work well together (eg in the way they handle apparent hotplug events
during a block write).

This version tidies up some style issues raised with version 2.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

 drivers/input/keyboard/maple_keyb.c |   40 +-
 drivers/mtd/maps/Kconfig            |   12 +-
 drivers/mtd/maps/Makefile           |    1 +
 drivers/mtd/maps/vmu-flash.c        |  825 +++++++++++++++++++++++++++++++++++
 drivers/sh/maple/maple.c            |  463 ++++++++++----------
 include/linux/maple.h               |   62 ++-
 6 files changed, 1138 insertions(+), 265 deletions(-)

