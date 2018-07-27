From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.18-rc6
Date: Thu, 26 Jul 2018 17:11:05 -0700
Message-ID: <20180727001105.GA93787@dtor-ws>
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

to receive updates for the input subsystem:

- a couple of new device IDs added to Elan i2c touchpad controller
  driver

- another entry in i8042 reset quirk list.

Changelog:
---------

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for serio device tree bindings

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Diffstat:
--------

 MAINTAINERS                           | 1 +
 drivers/input/mouse/elan_i2c_core.c   | 2 ++
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 3 files changed, 10 insertions(+)

Thanks.


-- 
Dmitry
