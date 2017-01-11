From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/3=5D=20Input=3A=20add=20optional=20amplifier=20regulator=20to=20pwm-beeper=E2=80=8B=20=28previously=20=22Input=3A=20add=20optional=20enable=20gpio=20to=20pwm-beeper=E2=80=8B=22=29?=
Date: Wed, 11 Jan 2017 14:01:58 -0600
Message-ID: <1484164921-30587-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This series adds an optional regulator to the pwm-beeper driver and device tree
bindings. The regulator acts as an amplifier that powers the beeper.

v2 changes:
* Changed from using a gpio to a regulator
* Rebased on the pwm-beeper cleanup series "Input: pwm-beeper - remove calls to
  legacy pwm_request API"


David Lechner (3):
  Input: pwm-beeper: suppress error message on probe defer
  dt-bindings: Input: Add optional amp-supply property to pwm-beeper
  Input: pwm-beeper: add optional amplifier regulator

 .../devicetree/bindings/input/pwm-beeper.txt       | 16 ++++++++++
 drivers/input/misc/pwm-beeper.c                    | 36 +++++++++++++++++++---
 2 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
