From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 00/17] Report power supply from hid-logitech-dj and others
Date: Tue, 17 Jan 2017 15:35:30 +0100
Message-ID: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey guys,

I tried to revive the in-kernel battery support for HID++ devices.
I was thinking of doing just a few patches, but in the end I had to do
cleanups and some more tweaks...

So, the final result is that now hid-logitech-hidpp should allow to
handle any HID++ device, no matter which connection it uses.
I was able to test it on some unifying devices, some USB and Bluetooth,
but I'd like to get the confirmation from Simon that I did not break
the G920.

Other than that, I implemented most features asked by Bastien during the
last round:
- have a sysfs file to indicate we are capable of power_supply
- use ONLINE capability (not sure if I mess something up or if Gnome handles
  it correctly)
- report product, serial and manufacturer
- report K750 battery info (not Lux, sorry)
- report HID++ 1.0 battery info

The interesting bit also is that now devices that behaves likes unifying
receivers can be handled with hid-logitech-hidpp (for the gaming mice, mostly),
which allows to have the real name and serial of the connected device, not just
"Logitech USB Receiver".

Nestor, Olivier, I can't include the G900 in the series. It seems the G900 is
using a different feature (0x1001?) for the battery. Could you sent me the
specs so I can had this one too?

Cheers,
Benjamin

Bastien Nocera (1):
  HID: logitech-hidpp: Add scope to battery

Benjamin Tissoires (16):
  HID: logitech-dj: allow devices to request full pairing information
  HID: logitech-hidpp: make sure we only register one battery per device
  HID: logitech-hidpp: battery: remove overloads and provide ONLINE
  HID: logitech-hidpp: forward device info in power_supply
  HID: logitech-hidpp: create the battery for all types of HID++ devices
  HID: logitech-hidpp: return an error if the feature is not present
  HID: logitech-hidpp: add support for battery status for the K750
  HID: logitech-hidpp: enable HID++ 1.0 battery reporting
  HID: logitech-hidpp: notify battery on connect
  HID: logitech-hidpp: add a sysfs file to tell we support power_supply
  HID: logitech-hidpp: allow non HID++ devices to be handled by this
    module
  HID: logitech-hidpp: make .probe usbhid capable
  HID: logitech-hidpp: do not query the name through HID++ for 1.0
    devices
  HID: logitech-hidpp: rework probe path for unifying devices
  HID: logitech-hidpp: report battery for the G700 over wireless
  HID: logitech-hidpp: retrieve the name of the gaming mice over
    wireless

 drivers/hid/hid-core.c           |   1 +
 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-logitech-dj.c    |  17 +-
 drivers/hid/hid-logitech-hidpp.c | 835 +++++++++++++++++++++++++++++++++------
 4 files changed, 736 insertions(+), 118 deletions(-)

-- 
2.9.3
