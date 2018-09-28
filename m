From: Joe Perches <joe@perches.com>
Subject: Bad MAINTAINERS pattern in section 'D-LINK DIR-685 TOUCHKEYS DRIVER'
Date: Fri, 28 Sep 2018 14:52:51 -0700
Message-ID: <20180928215251.29213-1-joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	4010	D-LINK DIR-685 TOUCHKEYS DRIVER
	4011	M:	Linus Walleij <linus.walleij@linaro.org>
	4012	L:	linux-input@vger.kernel.org
	4013	S:	Supported
-->	4014	F:	drivers/input/dlink-dir685-touchkeys.c

Commit that introduced this:

commit 131b3de7016b73fca1aba8ffb528217ac95b2505
 Author: Linus Walleij <linus.walleij@linaro.org>
 Date:   Mon Jun 5 14:48:44 2017 -0700
 
     Input: add D-Link DIR-685 touchkeys driver
     
     This adds support for the D-Link DIR-685 touchkeys found in the
     router with this name.
     
     The vendor code calles this a "touchpad" but we are registering
     it here under its real name.
     
     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
 
  .../bindings/input/dlink,dir685-touchkeys.txt      |  21 +++
  MAINTAINERS                                        |   6 +
  drivers/input/keyboard/Kconfig                     |  11 ++
  drivers/input/keyboard/Makefile                    |   1 +
  drivers/input/keyboard/dlink-dir685-touchkeys.c    | 155 +++++++++++++++++++++
  5 files changed, 194 insertions(+)

No commit with drivers/input/dlink-dir685-touchkeys.c found
