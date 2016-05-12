From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.6-rc7
Date: Thu, 12 May 2016 11:55:25 -0700
Message-ID: <20160512185525.GA25805@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36731 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbcELSz3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 14:55:29 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Chris Diamand (1):
      Input: byd - update copyright header

H. Nikolaus Schaller (1):
      Input: twl6040-vibra - fix DT node memory management

Marek Szyprowski (1):
      Input: max8997-haptic - fix NULL pointer dereference


Diffstat:
--------

 drivers/input/misc/max8997_haptic.c | 6 ++++--
 drivers/input/misc/twl6040-vibra.c  | 1 +
 drivers/input/mouse/byd.c           | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
Dmitry

