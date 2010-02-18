From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.33-rc7
Date: Thu, 18 Feb 2010 02:09:39 -0800
Message-ID: <20100218100938.GF13086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:35183 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab0BRKJu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 05:09:50 -0500
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

Alan Jenkins (1):
      Input: i8042 - fix KBC jam during hibernate

Matthew Garrett (1):
      Input: add KEY_RFKILL


Diffstat:
--------

 drivers/input/serio/i8042.c |    8 ++++++++
 include/linux/input.h       |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

-- 
Dmitry

