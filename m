From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Mon, 27 Mar 2017 16:59:20 +0200
Message-ID: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753543AbdC0PAd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this is finally a rework of the series that provides kernel power_supply
for hidpp devices.

This will allow upower to not handle those devices anymore and to have more
immediate reportng of the device to the system.

I have splitted the series to not support non unifying receivers here. I got
the non Unifying (DJ) receivers working locally, but given I am not so sure
it will not break the G920, I'd rather send a shorter series later (this one
is big enough already).

Cheers,
Benjamin

Bastien Nocera (1):
  HID: logitech-hidpp: Add scope to battery

Benjamin Tissoires (18):
  HID: logitech-dj: allow devices to request full pairing information
  HID: logitech-hidpp: make sure we only register one battery per device
  HID: logitech-hidpp: do not query the name through HID++ for 1.0
    devices
  HID: logitech-hidpp: create a capabilities bits field
  HID: logitech-hidpp: rework probe path for unifying devices
  HID: logitech-hidpp: retrieve the HID++ device name when available
  HID: logitech-hidpp: rework hidpp_connect_event()
  HID: logitech-hidpp: handle battery events in hidpp_raw_hidpp_event()
  HID: logitech-hidpp: forward device info in power_supply
  HID: logitech-hidpp: create the battery for all types of HID++ devices
  HID: logitech-hidpp: return an error if the queried feature is not
    present
  HID: logitech-hidpp: notify battery on connect
  HID: logitech-hidpp: battery: provide ONLINE property
  HID: logitech-hidpp: rename battery level into capacity
  HID: logitech-hidpp: battery: provide CAPACITY_LEVEL
  HID: logitech-hidpp: add support for battery status for the K750
  HID: logitech-hidpp: enable HID++ 1.0 battery reporting
  HID: logitech-hidpp: add a sysfs file to tell we support power_supply

 drivers/hid/hid-logitech-dj.c    |  19 +-
 drivers/hid/hid-logitech-hidpp.c | 741 +++++++++++++++++++++++++++++++++------
 2 files changed, 641 insertions(+), 119 deletions(-)

-- 
2.9.3

