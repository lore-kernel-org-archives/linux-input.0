From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.19-rc8
Date: Fri, 19 Oct 2018 10:45:08 -0700
Message-ID: <20181019174508.GA47209@dtor-ws>
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

to receive updates for the input subsystem. Just an addition to elan
touchpad driver ACPI table.

Changelog:
---------

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

Thanks.


-- 
Dmitry
