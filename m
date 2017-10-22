From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc5
Date: Sun, 22 Oct 2017 12:52:27 -0700
Message-ID: <20171022195227.mpnnddgc6sdegrel@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:48536 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdJVTwa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Oct 2017 15:52:30 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive a fix for a broken commit in the previous pull breaking
automatic module loading of input handlers, such ad evdev.

Changelog:
---------

Dmitry Torokhov (1):
      Input: do not use property bits when generating module alias

Diffstat:
--------

 scripts/mod/devicetable-offsets.c | 1 -
 scripts/mod/file2alias.c          | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

Thanks.


-- 
Dmitry
