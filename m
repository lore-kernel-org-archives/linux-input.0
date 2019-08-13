From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] Fix support of a few Logitech devices broken in 5.3
Date: Tue, 13 Aug 2019 15:38:05 +0200
Message-ID: <20190813133807.12384-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Jiri,

another set of patches to send to Linus ASAP.
It turns out that we have been breaking devices, so this should
be sent before 5.3 final.

Cheers,
Benjamin

Benjamin Tissoires (2):
  Revert "HID: logitech-hidpp: add USB PID for a few more supported
    mice"
  HID: logitech-hidpp: remove support for the G700 over USB

 drivers/hid/hid-logitech-hidpp.c | 22 ----------------------
 1 file changed, 22 deletions(-)

-- 
2.19.2
