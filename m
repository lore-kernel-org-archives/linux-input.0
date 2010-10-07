From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.36-rc7
Date: Wed, 6 Oct 2010 22:46:41 -0700
Message-ID: <20101007054641.GA23485@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45788 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab0JGFqr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Oct 2010 01:46:47 -0400
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

to receive updates for the input subsystem. I sat on these a little bit
too long but I believe 2.6.36 will be better with these fixes.

Changelog:
---------

Dmitry Torokhov (1):
      Input: wacom - fix runtime PM related deadlock

Henrik Rydberg (1):
      Input: uinput - setup MT usage during device creation

Kenneth Waters (1):
      Input: joydev - fix JSIOCSAXMAP ioctl


Diffstat:
--------

 drivers/input/joydev.c           |    3 +++
 drivers/input/misc/uinput.c      |    7 +++++++
 drivers/input/tablet/wacom_sys.c |   23 ++++++++++++-----------
 3 files changed, 22 insertions(+), 11 deletions(-)

