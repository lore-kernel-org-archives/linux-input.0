From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.32-rc7
Date: Mon, 16 Nov 2009 22:37:49 -0800
Message-ID: <20091117063748.GA6172@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41176 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZKQGhs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2009 01:37:48 -0500
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

Changelog:
---------

Abner Holsinger (1):
      Input: lifebook - fix settings for CF-72

Jiri Kosina (1):
      Input: psmouse - fix breakage introduced by b7802c5c1ea


Diffstat:
--------

 drivers/input/mouse/lifebook.c     |    3 +--
 drivers/input/mouse/psmouse-base.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Dmitry

