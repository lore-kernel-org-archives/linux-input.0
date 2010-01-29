From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.33-rc5
Date: Thu, 28 Jan 2010 23:12:30 -0800
Message-ID: <20100129071230.GE4177@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:57731 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0A2HMg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 02:12:36 -0500
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

to receive updates for the input subsystem. The ad7879 update is a bit
big to my taste but users want to use standard GPIO interface with the
driver and we don't want to continue carrying old sysfs interface for
another release.

Changelog:
---------

David H=E4rdeman (1):
      Input: winbond-cir - remove dmesg spam

Henrik Rydberg (2):
      Input: add the ABS_MT_PRESSURE event
      Input: update multi-touch protocol documentation

Jon Dodgson (1):
      Input: lifebook - add another Lifebook DMI signature

Michael Hennerich (1):
      Input: ad7879 - support auxiliary GPIOs via gpiolib


Diffstat:
--------

 Documentation/input/multi-touch-protocol.txt |   48 +++++-
 drivers/input/input.c                        |    1 +
 drivers/input/misc/winbond-cir.c             |    2 +-
 drivers/input/mouse/lifebook.c               |    6 +
 drivers/input/touchscreen/ad7879.c           |  197 ++++++++++++++++++=
--------
 include/linux/input.h                        |    1 +
 include/linux/spi/ad7879.h                   |   12 +-
 7 files changed, 198 insertions(+), 69 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
