From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.33-rc7
Date: Wed, 10 Feb 2010 22:45:37 -0800
Message-ID: <20100211064537.GC8252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:49850 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0BKGpn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 01:45:43 -0500
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

to receive updates for the input subsystem. There is a single fix for
reported 2.6.32 regression causing IBM trackpoint device to loose
user-supplied settings upon resume.

Changelog:
---------

Dmitry Torokhov (1):
      Input: psmouse - make sure we don't schedule reconnects after cleanup


Diffstat:
--------

 drivers/input/mouse/psmouse-base.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

-- 
Dmitry

