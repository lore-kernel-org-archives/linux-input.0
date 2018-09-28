From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.19-rc5
Date: Fri, 28 Sep 2018 16:57:51 -0700
Message-ID: <20180928235751.GA182564@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

Hi Greg,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few driver fixes.

Changelog:
---------

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Anson Huang (1):
      Input: egalax_ts - add system wakeup support

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Peter Hutterer (1):
      Input: uinput - allow for max == min during input_absinfo validation

Song Qiang (1):
      Input: gpio-keys - fix a documentation index issue

Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        |  2 +-
 drivers/input/keyboard/atakbd.c                    | 74 ++++++++--------------
 drivers/input/misc/uinput.c                        |  2 +-
 drivers/input/mouse/elantech.c                     |  2 +
 drivers/input/touchscreen/egalax_ts.c              |  6 ++
 5 files changed, 38 insertions(+), 48 deletions(-)

Thanks.


-- 
Dmitry
