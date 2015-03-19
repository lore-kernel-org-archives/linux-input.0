From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.0-rc4
Date: Thu, 19 Mar 2015 12:20:56 -0700
Message-ID: <20150319192056.GL30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38213 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbCSTVC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 15:21:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem: you will get an update to
Synaptics driver that makes it usable with the 2015 lineup from Lenovo.

Changelog:
---------

Benjamin Tissoires (8):
      Input: synaptics - skip quirks when post-2013 dimensions
      Input: synaptics - handle spurious release of trackstick buttons
      Input: synaptics - do not retrieve the board id on old firmwares
      Input: synaptics - retrieve the extended capabilities in query $10
      Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
      Input: synaptics - re-route tracksticks buttons on the Lenovo 2015 series
      Input: synaptics - remove X1 Carbon 3rd gen from the topbuttonpad list
      Input: synaptics - remove X250 from the topbuttonpad list

Daniel Martin (5):
      Input: synaptics - split synaptics_resolution(), query first
      Input: synaptics - log queried and quirked dimension values
      Input: synaptics - query min dimensions for fw v8.1
      Input: synaptics - remove obsolete min/max quirk for X240
      Input: synaptics - support min/max board id in min_max_pnpid_table

Dmitry Torokhov (2):
      Input: synaptics - fix middle button on Lenovo 2015 products
      Revert "Input: synaptics - use dmax in input_mt_assign_slots"


Diffstat:
--------

 drivers/input/mouse/synaptics.c | 212 +++++++++++++++++++++++++++++-----------
 drivers/input/mouse/synaptics.h |  28 ++++++
 2 files changed, 185 insertions(+), 55 deletions(-)

-- 
Dmitry

