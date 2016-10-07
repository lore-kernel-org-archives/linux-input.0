From: Schrempf Frieder <frieder.schrempf@exceet.de>
Subject: [PATCH v2 0/3] input: pwm-beeper: add feature to set volume level
Date: Fri, 7 Oct 2016 09:08:08 +0000
Message-ID: <1475831223-6006-1-git-send-email-frieder.schrempf@exceet.de>
References: <fe6349a5-7935-5be7-6dc1-7e80fa9dceeb@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:50854 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754585AbcJGJIL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 05:08:11 -0400
In-Reply-To: <fe6349a5-7935-5be7-6dc1-7e80fa9dceeb@exceet.de>
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "robh@kernel.org" <robh@kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "luis@debethencourt.com" <luis@debethencourt.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Schrempf Frieder <frieder.schrempf@exceet.de>

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The number of volume levels available and their values can
be specified via device tree (similar to pwm-backlight).

The volume adjustment is done by changing the duty cycle of
the pwm signal.

Changes in v2:
 - split into 3 separate patches
 - make volume devicetree properties optional
 - tested with Linux 4.7.4

Frieder Schrempf (3):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: add documentation for volume devicetree bindings
  input: pwm-beeper: add devicetree bindings to set volume levels

 .../ABI/testing/sysfs-class-input-pwm-beeper       |  17 +++
 .../devicetree/bindings/input/pwm-beeper.txt       |  22 ++++
 drivers/input/misc/pwm-beeper.c                    | 118 ++++++++++++++++++++-
 3 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-input-pwm-beeper

-- 
1.9.1
