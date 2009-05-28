From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.30-rc7
Date: Thu, 28 May 2009 12:02:30 -0700
Message-ID: <20090528190230.GD18589@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:48030 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbZE1TCe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2009 15:02:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. It contains couple small
tweaks and an update to mutlitouch protocol and its documentation.

Changelog:
---------

Dmitry Torokhov (1):
      Input: libps2 - better handle bad scheduler decisions

Henrik Rydberg (2):
      Input: multitouch - add tracking ID to the protocol
      Input: multitouch - augment event semantics documentation

Manuel Traut (1):
      Input: usb1400_ts - fix access to "device data" in resume function


Diffstat:
--------

 Documentation/input/multi-touch-protocol.txt |  103 ++++++++++++++++++++------
 drivers/input/input.c                        |    1 +
 drivers/input/serio/libps2.c                 |    2 +-
 drivers/input/touchscreen/ucb1400_ts.c       |    2 +-
 include/linux/input.h                        |    1 +
 5 files changed, 83 insertions(+), 26 deletions(-)

-- 
Dmitry

