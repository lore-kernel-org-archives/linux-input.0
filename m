From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] This patches set cros_ec_keyb as a wakeup source, so the chromeos's powerd
Date: Thu, 30 Mar 2017 17:50:48 +0800
Message-ID: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbasehore-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vic Yang <victoryang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Enric Balletbo Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

can control the keyboard's wakeup ability along with other ec event sources.


Jeffy Chen (2):
  input: cros_ec_keyb: Report wakeup events
  ARM: dts: cros-ec-keyboard: Enable as wakeup source

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
 drivers/input/keyboard/cros_ec_keyb.c   | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
