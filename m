From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.19-rc6
Date: Sun, 1 Feb 2015 11:55:47 -0800
Message-ID: <20150201195547.GA9097@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42920 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbBATzw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Feb 2015 14:55:52 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystmem - just a few quirks for PS/2
this time.

Changelog:
---------

Jochen Hein (1):
      Input: i8042 - add noloop quirk for Medion Akoya E7225 (MD98857)

Peter Hutterer (1):
      Input: synaptics - adjust min/max for Lenovo ThinkPad X1 Carbon 2nd

Rainer Koenig (1):
      Input: elantech - add more Fujtisu notebooks to force crc_enabled


Diffstat:
--------

 drivers/input/mouse/elantech.c        | 16 ++++++++++++++++
 drivers/input/mouse/synaptics.c       |  7 ++++---
 drivers/input/serio/i8042-x86ia64io.h |  8 ++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
Dmitry

