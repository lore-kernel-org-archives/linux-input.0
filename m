From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v5 0/3] input: pwm-beeper: add feature to set volume level
Date: Fri, 17 Feb 2017 10:54:40 +0100
Message-ID: <cover.1487323753.git.frieder.schrempf@exceet.de>
References: <cover.1487278130.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487278130.git.frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: dmitry.torokhov@gmail.com, david@lechnology.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The number of volume levels available and their values can
be specified via device tree (similar to pwm-backlight).

The volume adjustment is done by changing the duty cycle of
the pwm signal.

Changes in v5:
 - fix renaming of max_volume_level to max_volume
 - remove needless variable declaration

Frieder Schrempf (3):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: add documentation for volume devicetree bindings
  input: pwm-beeper: add devicetree bindings to set volume levels

 Documentation/ABI/testing/sysfs-devices-pwm-beeper |  17 ++++
 .../devicetree/bindings/input/pwm-beeper.txt       |  20 ++++
 drivers/input/misc/pwm-beeper.c                    | 110 ++++++++++++++++++++-
 3 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

-- 
2.7.4
