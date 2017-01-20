From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] HID: wacom: fixes for next
Date: Fri, 20 Jan 2017 16:20:10 +0100
Message-ID: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

well, these are non critical but nonetheless interesting fixes for
Wacom I was working on last week. I was waiting for the current v4.10
fix to be sent by Jason before pushing those out.

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: wacom: release the resources before leaving despite devm
  HID: wacom: remove warning while disconnecting devices
  HID: wacom: do not attempt to switch mode while in probe
  HID: wacom: do not shout an error on LED control

 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 42 ++++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.9.3
