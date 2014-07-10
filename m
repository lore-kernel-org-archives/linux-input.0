From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH 0/5] Input - wacom: battery enhancements and unifying
 hid-wacom and wacom
Date: Thu, 10 Jul 2014 22:14:04 +0100
Message-ID: <1405026844.2613.15.camel@fedora-lan>
References: <1405017900-16024-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from si-002-i161.relay.mailchannels.net ([108.178.49.173]:10198 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751170AbaGJXcf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 19:32:35 -0400
In-Reply-To: <1405017900-16024-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dnia 2014-07-10, czw o godzinie 14:44 -0400, Benjamin Tissoires pisze:
[..]
Hi Benjamin,
> However, I did not backport the speed attribute and the ac power
> device (which
> is infered by the battery status). I don't know if there are users of
> those two,
> so I let them aside for now. Przemo, any ideas if this is actually 
> used?
Both tablets that I had (Graphire Wireless and Intuos4 Wireless)
supports slow and fast reporting. Slow reporting is necessary with older
bluetooth receivers otherwise the lag between pen movement and cursor
movement made devices unusable.

I tried to expose all events reported by hardware and I think AC
reporting should stay in the kernel.

Intuos4 Wireless
AC power disconnected:
bash-4.2$ cat /sys/class/power_supply/wacom_ac/uevent 
POWER_SUPPLY_NAME=wacom_ac
POWER_SUPPLY_PRESENT=0
POWER_SUPPLY_ONLINE=0
POWER_SUPPLY_SCOPE=Device
bash-4.2$ cat /sys/class/power_supply/wacom_battery/uevent 
POWER_SUPPLY_NAME=wacom_battery
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_CAPACITY=85
POWER_SUPPLY_SCOPE=Device
POWER_SUPPLY_STATUS=Discharging

AC power connected:
bash-4.2$ cat /sys/class/power_supply/wacom_ac/uevent 
POWER_SUPPLY_NAME=wacom_ac
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_ONLINE=1
POWER_SUPPLY_SCOPE=Device
bash-4.2$ cat /sys/class/power_supply/wacom_battery/uevent 
POWER_SUPPLY_NAME=wacom_battery
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_CAPACITY=85
POWER_SUPPLY_SCOPE=Device
POWER_SUPPLY_STATUS=Charging
-- 
Kind regards,
Przemo Firszt

