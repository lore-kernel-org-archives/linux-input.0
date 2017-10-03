From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/4] Quirks cleanup and hid-generic niceness
Date: Tue,  3 Oct 2017 16:57:25 +0200
Message-ID: <20171003145729.3135-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

Niels found an issue with v1 of the series, while compiling the usbhid module
as a separate .ko.

Sending a v2 with the proper From: field fixed now.

I also use -M1 to show in 1/4 that usbhid/hid-quirks.c is basically moved to
hid-quirks.c.

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: core: move the dynamic quirks handling in core
  HID: quirks: move the list of special devices into a quirk
  HID: core: move the list of ignored devices in hid-quirks.c
  HID: core: remove the absolute need of hid_have_special_driver[]

 drivers/hid/Makefile            |    2 +-
 drivers/hid/hid-core.c          |  926 ++---------------------------
 drivers/hid/hid-generic.c       |   68 ++-
 drivers/hid/hid-quirks.c        | 1244 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/Makefile     |    2 +-
 drivers/hid/usbhid/hid-core.c   |   10 +-
 drivers/hid/usbhid/hid-quirks.c |  401 -------------
 include/linux/hid.h             |   21 +-
 net/bluetooth/hidp/core.c       |    2 +-
 9 files changed, 1391 insertions(+), 1285 deletions(-)
 create mode 100644 drivers/hid/hid-quirks.c
 delete mode 100644 drivers/hid/usbhid/hid-quirks.c

-- 
2.9.5
