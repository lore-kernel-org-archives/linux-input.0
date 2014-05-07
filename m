From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [RFC/PATCH 0/3] add adp5589 dt support
Date: Wed,  7 May 2014 10:00:41 -0300
Message-ID: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
List-Id: linux-input@vger.kernel.org

This patchset enables adp5589 keypad configuration via dt. Until now,
this was only done via platform data.

The adp5589 has many functions besides matrix keypad decoding. For now,
we only support keypad related functionality: including scan time and
pull resistors configuration.

  Patch 1 adds the functionality to the driver. There is a minor change
in old code to properly detect the device type if we're using DT.

  Patch 2 adds a DT include file to specify the chip lines for the pull
configuration with symbolic names.

  Patch 3 adds the binding documentation

Guido Mart=C3=ADnez (3):
  drivers: input: keyboard: adp5589: add DT support
  DT: input: adp5589: add adp5589 include file
  DT: input: adp5589: add binding documentation

 .../devicetree/bindings/input/adp5589.txt          |  63 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 207 +++++++++++++=
+++++++-
 include/dt-bindings/input/adp5589.h                |   7 +
 3 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/adp5589.txt
 create mode 100644 include/dt-bindings/input/adp5589.h

--=20
2.0.0.rc0
