From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] Fix OF match for adxl34x driver
Date: Thu, 21 May 2015 13:42:24 +0200
Message-ID: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

	Hi Dmitry,

This is a resent of a series by Laurent Pinchart to fix OF matching for
the adxl34x driver.

According to the discussion in response to that series, we were under
the impression this was going in through the input tree
(http://www.spinics.net/lists/linux-i2c/msg18293.html).

In input patchwork, the series is still marked "Awaiting Upstream"
(https://patchwork.ozlabs.org/project/linux-i2c/list/?state=*&q=adxl),
but actually we are waiting for you, as we can't update the affected DTS
before the driver fix has gone in ;-)

>From Laurent's submission:

    This patch set fixes OF matching for the adxl34x driver when the DT
    node lists a device-specific "adi,adxl345" or "adi,adxl346"
    compatible value first.

    The first version (see
    http://www.spinics.net/lists/linux-i2c/msg18107.html) added an OF
    match entry for the "adi,adxl34x" compatible string. The discussion
    that followed concluded that that compatible string should be
    deprecated and that the driver should match the device-specific
    strings instead.

    The first patch thus deprecates the "adi,adxl34x" compatible string
    by removing it the DT trivial devices list, and the second patch
    then adds an OF match table to the adxl34x driver.

Thanks for applying!

Laurent Pinchart (2):
  DT: i2c: Deprecate adi,adxl34x compatible string
  input: adxl34x: Add OF match support

 .../devicetree/bindings/i2c/trivial-devices.txt     |  3 +--
 drivers/input/misc/adxl34x-i2c.c                    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
