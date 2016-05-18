From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.7-rc0
Date: Wed, 18 May 2016 11:35:42 -0700
Message-ID: <20160518183542.GA6829@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36572 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbcERSfq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2016 14:35:46 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive first round of updates for the input subsystem. No new
drivers here, just some driver fixes.

Changelog:
---------

Andreas F=E4rber (1):
      Input: gpio-keys - clean up device tree binding example

Clifton Barnes (1):
      Input: rotary-encoder - fix bare use of 'unsigned'

Dmitry Torokhov (4):
      Input: omap-keypad - remove adjusting of scan delay
      Input: omap-keypad - drop empty PM stubs
      Input: omap-keypad - remove set_col_gpio_val() and get_row_gpio_v=
al()
      Input: ti_am335x_tsc - use SIMPLE_DEV_PM_OPS

=46lorian Euchner (1):
      Input: cm109 - fix handling of volume and mute buttons

Geert Uytterhoeven (1):
      Input: bcm_iproc_tsc - DT spelling s/clock-name/clock-names/

H. Nikolaus Schaller (1):
      Input: twl6040-vibra - remove mutex

Ming Lei (1):
      Input: cm109 - spin_lock in complete() cleanup

Oliver Neukum (4):
      Input: acecad - stop saving struct usb_device
      Input: aiptek - stop saving struct usb_device
      Input: gtco - stop saving struct usb_device
      Input: kbtab - stop saving struct usb_device

Raveendra Padasalagi (1):
      Input: bcm_iproc_tsc - use syscon to access shared registers

Rui Teng (1):
      Input: twl4030 - fix unsafe macro definition

Vladimir Zapolskiy (1):
      Input: byd - don't wipe dynamically allocated memory twice


Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        | 10 +--
 .../input/touchscreen/brcm,iproc-touchscreen.txt   | 23 +++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 11 +++-
 drivers/input/keyboard/omap-keypad.c               | 52 +-------------=
-
 drivers/input/keyboard/twl4030_keypad.c            | 28 ++++----
 drivers/input/misc/cm109.c                         | 47 +++++++++----
 drivers/input/misc/rotary_encoder.c                |  8 +--
 drivers/input/misc/twl6040-vibra.c                 | 15 +----
 drivers/input/mouse/byd.c                          |  1 -
 drivers/input/tablet/acecad.c                      | 12 ++--
 drivers/input/tablet/aiptek.c                      | 20 +++---
 drivers/input/tablet/gtco.c                        | 24 +++----
 drivers/input/tablet/kbtab.c                       |  8 +--
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 77 ++++++++++++--=
--------
 drivers/input/touchscreen/ti_am335x_tsc.c          | 16 ++---
 15 files changed, 170 insertions(+), 182 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
