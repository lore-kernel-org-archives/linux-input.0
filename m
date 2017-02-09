From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.10-rc7
Date: Thu, 9 Feb 2017 10:06:05 -0800
Message-ID: <20170209180605.GA8862@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32973 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdBISIf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2017 13:08:35 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a fix for crash
in uinput, and a fix for build errors when HID-RMI is built-in but SERIO
is a module.

Changelog:
---------

Arnd Bergmann (1):
      Input: synaptics-rmi4 - select 'SERIO' when needed

Dmitry Torokhov (1):
      Input: uinput - fix crash when mixing old and new init style


Diffstat:
--------

 drivers/input/misc/uinput.c | 20 ++++++++++++++------
 drivers/input/rmi4/Kconfig  |  8 +++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)


-- 
Dmitry

