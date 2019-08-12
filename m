From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] HID: do not call hid_set_drvdata(hdev, NULL) in drivers
Date: Mon, 12 Aug 2019 18:27:38 +0200
Message-ID: <20190812162740.15898-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

the wacom one is split dfrom the other drivers as the change is slightly
bigger.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: do not call hid_set_drvdata(hdev, NULL) in drivers
  HID: wacom: do not call hid_set_drvdata(hdev, NULL)

 drivers/hid/hid-cougar.c       |  6 ++----
 drivers/hid/hid-gfrm.c         |  7 -------
 drivers/hid/hid-lenovo.c       |  2 --
 drivers/hid/hid-picolcd_core.c |  7 +------
 drivers/hid/hid-sensor-hub.c   |  1 -
 drivers/hid/wacom_sys.c        | 18 +++++-------------
 6 files changed, 8 insertions(+), 33 deletions(-)

-- 
2.19.2
