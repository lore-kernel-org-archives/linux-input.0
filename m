From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.3-rc5
Date: Fri, 16 Oct 2015 17:12:13 -0700
Message-ID: <20151017001213.GA2694@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just 2 small fixups to
ads7846 touchscreen controller driver and Cypress touchpad driver.

Changelog:
---------

Andrey Gelman (1):
      Input: ads7846 - correct the value got from SPI

Dudley Du (1):
      Input: cyapa - fix the copy paste error on electrodes_rx value


Diffstat:
--------

 drivers/input/mouse/cyapa_gen6.c    | 10 +++-------
 drivers/input/touchscreen/ads7846.c |  8 ++++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

Thanks.

-- 
Dmitry
