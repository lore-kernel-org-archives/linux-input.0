From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc6
Date: Sat, 28 Oct 2017 10:52:05 -0700
Message-ID: <20171028175205.uopniotnuhif2e66@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- a change to gtco tablet driver tightening parsing of HID descriptors;

- a new ACPI ID added to Elan driver to be able to handle touchpads
  found in Lenovo Ideapad 320/520;

- a fix to Symaptics RMI4 driver to adjust handling of buttons.

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - limit the range of what GPIOs are buttons

Dmitry Torokhov (1):
      Input: gtco - fix potential out-of-bound access

Kai-Heng Feng (1):
      Input: elan_i2c - add ELAN0611 to the ACPI table

Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c |  1 +
 drivers/input/rmi4/rmi_f30.c        |  5 +++--
 drivers/input/tablet/gtco.c         | 17 ++++++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

Thanks.


-- 
Dmitry
