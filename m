From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Thu, 1 Jun 2017 11:06:11 -0700
Message-ID: <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdFASGM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 1 Jun 2017 14:06:12 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/27/2017 07:59 AM, Benjamin Tissoires wrote:
> this is finally a rework of the series that provides kernel power_supply
> for hidpp devices.
> 
> This will allow upower to not handle those devices anymore and to have more
> immediate reportng of the device to the system.

FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery as
if it were a laptop battery.  It's mostly garbage, and always reports
0%, which makes upower always tell me my laptop is 2/3 charged (I have 2
real batteries).

Is this expected?

> $ upower --dump
> Device: /org/freedesktop/UPower/devices/battery_hidpp_battery_0
>   native-path:          hidpp_battery_0
>   vendor:               Logitech
>   model:                Performance MX
>   serial:               101a-92-ca-86-1e
>   power supply:         no
>   updated:              Thu 01 Jun 2017 11:04:02 AM PDT (22 seconds ago)
>   has history:          yes
>   has statistics:       yes
>   battery
>     present:             yes
>     rechargeable:        yes
>     state:               discharging
>     energy:              0 Wh
>     energy-empty:        0 Wh
>     energy-full:         0 Wh
>     energy-full-design:  0 Wh
>     energy-rate:         0 W
>     percentage:          0%
>     capacity:            100%
>   History (charge):
>     1496340177	0.000	unknown
>   History (rate):
>     1496340177	0.000	unknown

$ upower --version
UPower client version 0.9.23
UPower daemon version 0.9.23


