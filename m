From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.10-rc6
Date: Tue, 31 Jan 2017 10:42:49 -0800
Message-ID: <20170131184249.GC13642@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33130 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdAaSmx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 13:42:53 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a fix for crash
in wm97xx driver and synaptics-rmi4 will stop throwing erroneous
warnings.

Changelog:
---------

Christophe JAILLET (1):
      Input: synaptics-rmi4 - fix reversed conditions in enable/disable_irq_wake

Manuel Lauss (1):
      Input: wm97xx - make missing platform data non-fatal


Diffstat:
--------

 drivers/input/rmi4/rmi_driver.c         | 4 ++--
 drivers/input/touchscreen/wm97xx-core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Dmitry

