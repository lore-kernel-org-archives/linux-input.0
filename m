From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/3] switch hid-rmi to rmi_core
Date: Tue,  3 Jan 2017 16:16:00 +0100
Message-ID: <20170103151603.26844-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

this is mostly a resend of the v2, with only the HID bits now that the input
bits are in Linus' tree.

The only change is in the Kconfig where I force RMI4 F03 to be there too
to support trackstick.

Andrew, I think you already tested it last time, but I wouldn't mind an other
round of tests :)

Cheers,
Benjamin

Andrew Duggan (3):
  HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
  HID: rmi: Handle all Synaptics touchpads using hid-rmi
  HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi

 drivers/hid/Kconfig    |   5 +
 drivers/hid/hid-core.c |   4 +-
 drivers/hid/hid-ids.h  |   1 +
 drivers/hid/hid-rmi.c  | 974 +++++++------------------------------------------
 4 files changed, 150 insertions(+), 834 deletions(-)

-- 
2.9.3
