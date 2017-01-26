From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Thu, 26 Jan 2017 16:02:05 +0100
Message-ID: <1485442925.5845.27.camel@hadess.net>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
List-Id: linux-input@vger.kernel.org

On Wed, 2016-06-29 at 19:28 +1000, Peter Hutterer wrote:
> If the 0x1000 Unified Battery Level Status feature exists, expose the battery
> level.
> 
> The main drawback is that while a device is plugged in its battery level is 0.
> To avoid exposing that as 0% charge we make up a number based on the charging
> status.

The reason why you don't get a proper state for the K750 is because it
doesn't export a battery status of its own. The UPower code uses a
heuristic based on the status of the solar panel:
if (priv->lux > 200) {
	priv->batt_status = HIDPP_DEVICE_BATT_STATUS_CHARGING;
} else {
	priv->batt_status = HIDPP_DEVICE_BATT_STATUS_DISCHARGING;
}

This is the code in UPower:
https://cgit.freedesktop.org/upower/tree/src/linux/hidpp-device.c#n914

The heuristics seem to be fairly consistent with the light level button
on the keyboard, which shows green or red depending on whether the
device is charging or discharging.

This hunk of code is also the reason why the battery percentage doesn't
match:

kernel hidpp code:
Device: /org/freedesktop/UPower/devices/keyboard_hidpp_battery_4
  native-path:          hidpp_battery_4
    percentage:          1%

UPower's hidpp code:
Device: /org/freedesktop/UPower/devices/keyboard_0003o046Do4002x000F
  native-path:          /sys/devices/pci0000:00/0000:00:14.0/usb3/3-
10/3-10:1.2/0003:046D:C52B.000E/0003:046D:4002.000F
    percentage:          95%

Cheers
