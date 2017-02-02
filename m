From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 00/15] Report power supply from hid-logitech-hidpp
Date: Thu,  2 Feb 2017 15:12:14 +0100
Message-ID: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This is the v2 of the series which aims at adding kernel support for the
power_supply reporting of the HID++ devices.
I updated the series with the comments from Bastien:
- fixed K750 battery state
- fixed the model names of the devices

I also stripped out the less than optimal patches that added plain HID++ for
USB devices (need to work on that later), and I fixed a couple of issues
along the road.

Cheers,
Benjamin

Bastien Nocera (1):
  HID: logitech-hidpp: Add scope to battery

Benjamin Tissoires (14):
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
  HID: logitech-hidpp: do not query the name through HID++ for 1.0
    devices
  HID: logitech-hidpp: rework probe path for unifying devices
  HID: logitech-hidpp: retrieve the HID++ device name when available
  HID: logitech-hidpp: rework hidpp_connect_event()

 drivers/hid/hid-logitech-dj.c    |  17 +-
 drivers/hid/hid-logitech-hidpp.c | 554 +++++++++++++++++++++++++++++++++------
 2 files changed, 480 insertions(+), 91 deletions(-)

-- 
2.9.3
