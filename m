From: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
Subject: [PATCH v2] input: touchscreen: add driver for Zeitec ZET6223
Date: Tue, 13 Sep 2016 23:08:25 +0200
Message-ID: <20160913210826.30676-1-jelle@vdwaa.nl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is the v2 version of the Zeitec ZET6223 touchscreen i2c driver.

I forgot to include the vendors datasheet in the first patch set, I linked it below. [0]

Changes in v2:
* Fix double indentation in open/close handler
* Rewrite C++ style comments to C style
* Simplify check valid finger bits
* Fix double space in dev_err
* Check if the number of fingers is bigger then 16, if it's bigger then
  16 numbers then limit it to 16.
* Drop INPUT_MT_TRACK since the firmware tracks fingers.
* Add of_match table
* Rename power_gpios to reset_gpios since the datasheet names this pin
  the reset pin. This pin can be set to low for uploading firmware

[0] http://www.zeitecsemi.com/dokuwiki/lib/exe/fetch.php?media=product_spec_6223:zp-hw-ps-0007_zet6223_product_spec_v1.0.pdf

Jelle van der Waa (1):
  input: touchscreen: add driver for Zeitec ZET6223

 .../bindings/input/touchscreen/zet6223.txt         |  32 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/touchscreen/Kconfig                  |  11 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/zet6223.c                | 207 +++++++++++++++++++++
 5 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
 create mode 100644 drivers/input/touchscreen/zet6223.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
