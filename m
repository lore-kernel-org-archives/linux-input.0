From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 0/3] HID: switch hid-rmi to rmi_core
Date: Thu,  5 Jan 2017 09:48:57 +0100
Message-ID: <20170105084900.15931-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Small revision to add irq.h in hid-rmi.c, as reported by the Intel
kbuild test bot and by Andrew.

Cheers,
Benjamin

Andrew Duggan (3):
  HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
  HID: rmi: Handle all Synaptics touchpads using hid-rmi
  HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi

 drivers/hid/Kconfig    |   5 +
 drivers/hid/hid-core.c |   4 +-
 drivers/hid/hid-ids.h  |   1 +
 drivers/hid/hid-rmi.c  | 975 +++++++------------------------------------------
 4 files changed, 151 insertions(+), 834 deletions(-)

-- 
2.9.3
