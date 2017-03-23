From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.11-rc3
Date: Thu, 23 Mar 2017 14:52:58 -0700
Message-ID: <20170323215258.GC11818@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33826 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCWVxC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 17:53:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get fixes to
various USB drivers to validate existence of endpoints before trying to
use them, fixes to APLS v8 protocol, and a couple of i8042 quirks.

Changelog:
---------

Benjamin Tissoires (1):
      Input: synaptics-rmi4 - prevent null pointer dereference in f30

Dmitry Torokhov (1):
      Input: i8042 - add TUXEDO BU1406 (N24_25BU) to the nomux list

Johan Hovold (7):
      Input: iforce - validate number of endpoints before using them
      Input: cm109 - validate number of endpoints before using them
      Input: ims-pcu - validate number of endpoints before using them
      Input: yealink - validate number of endpoints before using them
      Input: hanwang - validate number of endpoints before using them
      Input: kbtab - validate number of endpoints before using them
      Input: sur40 - validate number of endpoints before using them

Kai-Heng Feng (1):
      Input: i8042 - add noloop quirk for Dell Embedded Box PC 3000

Masaki Ota (2):
      Input: ALPS - fix V8+ protocol handling (73 03 28)
      Input: ALPS - fix trackstick button handling on V8 devices

Matjaz Hegedic (1):
      Input: elan_i2c - add ASUS EeeBook X205TA special touchpad fw


Diffstat:
--------

 drivers/input/joystick/iforce/iforce-usb.c |  3 ++
 drivers/input/misc/cm109.c                 |  4 ++
 drivers/input/misc/ims-pcu.c               |  4 ++
 drivers/input/misc/yealink.c               |  4 ++
 drivers/input/mouse/alps.c                 | 72 +++++++++++++++++++++---------
 drivers/input/mouse/alps.h                 | 11 +++++
 drivers/input/mouse/elan_i2c_core.c        | 20 +++++----
 drivers/input/rmi4/rmi_f30.c               |  4 ++
 drivers/input/serio/i8042-x86ia64io.h      | 14 ++++++
 drivers/input/tablet/hanwang.c             |  3 ++
 drivers/input/tablet/kbtab.c               |  3 ++
 drivers/input/touchscreen/sur40.c          |  3 ++
 12 files changed, 116 insertions(+), 29 deletions(-)

-- 
Dmitry

