From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.12-rc4
Date: Fri, 9 Jun 2017 17:33:46 -0700
Message-ID: <20170610003346.GA35678@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35575 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFJAdt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 20:33:49 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- mark "guest" RMI device as pass-through port to avoid "phantom" ALPS
  toouchpad on newer Lenovo Carbons

- add 2 more laptops to the Elantech's lists of devices using CRC mode

Changelog:
---------

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - register F03 port as pass-through serio

Ulrik De Bie (1):
      Input: elantech - add Fujitsu Lifebook E546/E557 to force crc_enabled

Diffstat:
--------

 drivers/input/mouse/elantech.c | 16 ++++++++++++++++
 drivers/input/rmi4/rmi_f03.c   |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

Thanks.


-- 
Dmitry
