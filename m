From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc1
Date: Fri, 10 Jul 2015 17:05:50 -0700
Message-ID: <20150711000550.GD35720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33281 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbbGKH1g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 03:27:36 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You'll get a fix (revert)
for a recent regression in Synaptics driver and a fix for Elan i2c
touchpad driver.

Changelog:
---------

Dmitry Torokhov (1):
      Revert "Input: synaptics - allocate 3 slots to keep stability in image sensors"

duson (1):
      Input: elan_i2c - change the hover event from MT to ST


Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c | 12 +++++-------
 drivers/input/mouse/synaptics.c     |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
Dmitry

