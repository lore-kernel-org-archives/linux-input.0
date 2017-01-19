From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v3 0/3] input: pwm-beeper: add feature to set volume level
Date: Thu, 19 Jan 2017 16:24:07 +0100
Message-ID: <cover.1484838551.git.frieder.schrempf@exceet.de>
References: <0e2dec4d-7550-9495-f12a-020391183304@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:60991 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbdASP1q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 10:27:46 -0500
In-Reply-To: <0e2dec4d-7550-9495-f12a-020391183304@exceet.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh@kernel.org
Cc: dmitry.torokhov@gmail.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The number of volume levels available and their values can
be specified via device tree (similar to pwm-backlight).

The volume adjustment is done by changing the duty cycle of
the pwm signal.

Changes in v3:
 - update date
 - change description of volume-levels to be used for linear levels

Frieder Schrempf (3):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: add documentation for volume devicetree bindings
  input: pwm-beeper: add devicetree bindings to set volume levels

 .../ABI/testing/sysfs-class-input-pwm-beeper       |  17 +++
 .../devicetree/bindings/input/pwm-beeper.txt       |  20 ++++
 drivers/input/misc/pwm-beeper.c                    | 116 ++++++++++++++++++++-
 3 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-input-pwm-beeper

-- 
2.7.4

