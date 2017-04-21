From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.11-rc7
Date: Thu, 20 Apr 2017 19:01:27 -0700
Message-ID: <20170421020127.GA23279@dtor-ws>
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

to receive updates for the input subsystem - an update to Elan PS/2
driver to allow working on yet another Lifebook.

Changelog:
---------

Thorsten Leemhuis (1):
      Input: elantech - add Fujitsu Lifebook E547 to force crc_enabled


Diffstat:
--------

 drivers/input/mouse/elantech.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Dmitry
