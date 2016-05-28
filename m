From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.7-rc0 (part 2)
Date: Fri, 27 May 2016 17:19:25 -0700
Message-ID: <20160528001925.GA38861@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34407 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbcE1AT3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2016 20:19:29 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few more driver
fixes; new drivers will be coming in the next merge window.

There will be a trivial conflict in drivers/input/misc/pwm-beeper.c,
please keep both parts so you'll end up with the following chunk:

	/*
	 * FIXME: pwm_apply_args() should be removed when switching to
	 * the atomic PWM API.
	 */
	pwm_apply_args(beeper->pwm);

	INIT_WORK(&beeper->work, pwm_beeper_work);


Changelog:
---------

Cameron Gutman (1):
      Input: xpad - prevent spurious input from wired Xbox 360 controllers

Manfred Schlaegl (1):
      Input: pwm-beeper - fix - scheduling while atomic

Pavel Rojtberg (3):
      Input: xpad - move pending clear to the correct location
      Input: xpad - add more third-party controllers
      Input: xpad - xbox one elite controller support

Ricky Liang (1):
      Input: uinput - handle compat ioctl for UI_SET_PHYS


Diffstat:
--------

 drivers/input/joystick/xpad.c   | 18 +++++++++--
 drivers/input/misc/pwm-beeper.c | 69 ++++++++++++++++++++++++++++-------------
 drivers/input/misc/uinput.c     |  6 ++++
 3 files changed, 70 insertions(+), 23 deletions(-)

-- 
Dmitry
