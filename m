From: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v4 0/3] input: pwm-beeper: add feature to set volume level
Date: Thu, 16 Feb 2017 22:08:27 +0100
Message-ID: <cover.1487278130.git.frieder.schrempf@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1484838551.git.frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The number of volume levels available and their values can
be specified via device tree (similar to pwm-backlight).

The volume adjustment is done by changing the duty cycle of
the pwm signal.

Changes in v4:
 - move sysfs attributes from class/input to devices/pwm-beeper
 - rename max_volume_level to max_volume
 - move array allocation to probe function
 - rename attribute structs
 - remove needless code
 - update date
 - use generic device properties instead of dt properties

Frieder Schrempf (3):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: add documentation for volume devicetree bindings
  input: pwm-beeper: add devicetree bindings to set volume levels

 Documentation/ABI/testing/sysfs-devices-pwm-beeper |  17 ++++
 .../devicetree/bindings/input/pwm-beeper.txt       |  20 ++++
 drivers/input/misc/pwm-beeper.c                    | 111 ++++++++++++++++++++-
 3 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
