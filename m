From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] few reverts and fixes for 5.2
Date: Wed,  5 Jun 2019 14:44:04 +0200
Message-ID: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This has been already publicly discussed here, so I am just posting
for completeness.

patch 1:
request to revert it:
https://patchwork.kernel.org/patch/10844177/#22651385

patch 2&3:
related thread:
https://lkml.org/lkml/2019/5/28/778

patch 4:
bug link: https://bugzilla.kernel.org/show_bug.cgi?id=203619
and related thread: https://lkml.org/lkml/2019/5/28/778

Cheers,
Benjamin

Benjamin Tissoires (3):
  Revert "HID: Increase maximum report size allowed by
    hid_field_extract()"
  Revert "HID: core: Do not call request_module() in async context"
  Revert "HID: core: Call request_module before doing device_add"

Hans de Goede (1):
  HID: logitech-dj: Fix 064d:c52f receiver support

 drivers/hid/hid-core.c        | 16 +++----------
 drivers/hid/hid-logitech-dj.c | 42 ++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.19.2
