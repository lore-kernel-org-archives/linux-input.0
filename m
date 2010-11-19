From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.37-rc1
Date: Fri, 19 Nov 2010 09:18:43 -0800
Message-ID: <20101119171843.GD6236@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59133 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab0KSRSw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 12:18:52 -0500
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

to receive updates for the input subsystem.

There is a fix for keycode mapping regression affecting mostly
sony-laptop users; fix for regression in SysRq handling code causing it
to swallow lone Alt+SysRq (without any follow up action) so that print
screen shortcuts stopped working, and a patch that tightens security on
Aiptek sysfs attributes.

Changelog:
---------

Dmitry Torokhov (2):
      Input: sysrq - pass along lone Alt + SysRq
      Input: aiptek - tighten up permissions on sysfs attributes

Mattia Dongili (1):
      Input: fix typo in keycode validation supporting large scancodes


Diffstat:
--------

 drivers/input/input.c         |    2 +-
 drivers/input/tablet/aiptek.c |   28 ++++----
 drivers/tty/sysrq.c           |  169 ++++++++++++++++++++++++++++++-----------
 3 files changed, 139 insertions(+), 60 deletions(-)

-- 
Dmitry

