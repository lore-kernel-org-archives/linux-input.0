From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.1-rc7
Date: Tue, 9 Jun 2015 11:49:37 -0700
Message-ID: <20150609184937.GM6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38143 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119AbbFIStn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 14:49:43 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive a small tweak for Synaptics PS/2 touchpad driver.

Changelog:
---------

Peter Hutterer (1):
      Input: synaptics - add min/max quirk for Lenovo S540


Diffstat:
--------

 drivers/input/mouse/synaptics.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
Dmitry

