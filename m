From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 0/2] HID: multitouch: Support Asus T304UA media keys
Date: Mon, 24 Jul 2017 14:22:23 -0700
Message-ID: <20170724212225.3426-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38009 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdGXVWo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 17:22:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The Asus T304UA convertible sports a magnetic detachable keyboard with
touchpad, which is connected over USB. Most of the keyboard hotkeys are exposed
through the same USB interface as the touchpad.

The mapping defined here is the same present in hid-asus, but when using
hid-asus to drive this touchpad, we lose the multitouch funcionality. In my
experiments, when trying to add mark this USB id with QUIRK_IS_MULTITOUCH in
hid-asus, both the keyboard and touchpad stop responding.

I would be happy to re-work this series if some guidance is provided on how
these kind of mappings should be implemented (is it ok to have vendor-specific
mappings in hid-multitouch? how can we keep the mt funcionality if using
hid-asus? how can we bing hid-asus only to the to USB interface?).

Bellow is the output from usb-devices, where If#=0 exports the keyboard and
If#=1 exports the touchpad and media keys.

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=03 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=184a Rev=11.02
S:  Product=ASUS Touchpad and G-sensor Keyboard
C:  #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid

João Paulo Rechi Vita (2):
  HID: multitouch: Support HID_GD_WIRELESS_RADIO_CTLS
  HID: multitouch: Support Asus T304UA media keys

 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 48 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/hid.h          |  2 ++
 3 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.13.2

