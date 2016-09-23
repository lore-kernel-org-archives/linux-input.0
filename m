From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.8-rc7
Date: Fri, 23 Sep 2016 14:27:01 -0700
Message-ID: <20160923212701.GA25499@dtor-ws>
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

to receive updates for the input subsystem. Just a fix up for the
firmware handling to the Silead driver (which is a new driver in this
release).

Changelog:
---------

Hans de Goede (2):
      Input: silead_gsl1680 - document firmware-name, fix implementation
      Input: silead_gsl1680 - use "silead/" prefix for firmware loading


Diffstat:
--------

 .../bindings/input/touchscreen/silead_gsl1680.txt        |  1 +
 drivers/input/touchscreen/silead.c                       | 16 +++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
Dmitry
