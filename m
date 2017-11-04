From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc7
Date: Fri, 3 Nov 2017 17:20:51 -0700
Message-ID: <20171104002051.ciabxuxjwclasbfz@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:47563 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbdKDAUy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Nov 2017 20:20:54 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a couple of fixups to
sparse-keymap module and Microchip AR1021 touchscreen driver.

Changelog:
---------

Martin Kepplinger (1):
      Input: ar1021_i2c - set INPUT_PROP_DIRECT

Stefan Brüns (1):
      Input: sparse-keymap - send sync event for KE_SW/KE_VSW

Diffstat:
--------

 drivers/input/sparse-keymap.c          | 1 +
 drivers/input/touchscreen/ar1021_i2c.c | 1 +
 2 files changed, 2 insertions(+)

Thanks.


-- 
Dmitry
