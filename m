From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/7] HID: logitech-hidpp: support non DJ devices
Date: Fri,  7 Sep 2018 12:34:43 +0200
Message-ID: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Jiri, Nestor,

I have this series in my tree for a while now (first commit was in January).
I never sent it (as far as I can remember*) because I was requesting
feedback regarding the G920 wheel. I think I haven't break it, but
mistakes can happen.

Anyway, I think it's been too long, so I am just sending it now, as
it will fix the names of the non-dj devices that share the same USB receiver
(G900 and G403 for instance). Also, rebasing on top of new code is a pain
I'd rather not do every 3 months.

Cheers,
Benjamin

* looking into my archives, I actually sent those as a part of the
battery support in hid-logitech-hidpp. Consider it as a fresh start though :)

Benjamin Tissoires (7):
  HID: logitech-hidpp: allow non HID++ devices to be handled by this
    module
  HID: logitech-hidpp: make .probe usbhid capable
  HID: logitech-hidpp: support non-DJ receivers
  HID: logitech-hidpp: get the name and serial of the other non-HID++
    node
  HID: logitech-hidpp: create a name based on the type if non available
  HID: logitech-hidpp: support the G700 over wireless
  HID: logitech-hidpp: support the G900 over wireless

 drivers/hid/hid-ids.h            |   4 +
 drivers/hid/hid-logitech-hidpp.c | 470 +++++++++++++++++++++++++++++++++------
 2 files changed, 407 insertions(+), 67 deletions(-)

-- 
2.14.3
