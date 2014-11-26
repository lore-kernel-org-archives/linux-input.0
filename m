From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.18-rc6
Date: Wed, 26 Nov 2014 08:45:06 -0800
Message-ID: <20141126164506.GA28274@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:40952 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaKZQzI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2014 11:55:08 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. The main change is to fix breakage
in Elantech driver introduced by the recent commit adding trackpoint reporting
to protocol v4. Now we are trusting the hardware to advertise the trackpoint
properly and do not try to decode the data as trackpoint if firmware told us
it is not present.

Changelog:
---------

Ben Sagal (1):
      Input: synaptics - adjust min/max on Thinkpad E540

Dmitry Torokhov (1):
      Input: elantech - trust firmware about trackpoint presence

Greg Kroah-Hartman (1):
      Input: xpad - use proper endpoint type


Diffstat:
--------

 drivers/input/joystick/xpad.c   | 16 +++++++++++++---
 drivers/input/mouse/elantech.c  | 10 +---------
 drivers/input/mouse/synaptics.c |  4 ++++
 3 files changed, 18 insertions(+), 12 deletions(-)

Thanks.

-- 
Dmitry

