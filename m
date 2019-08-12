From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] HID multitouch: small fixes
Date: Mon, 12 Aug 2019 18:23:24 +0200
Message-ID: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Fend <Matthias.Fend@wolfvision.net>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

First one should prevent us to add more quirks for Win8 devices
that have a trackstick.
Second one is a weird device that doesnt work properly in recent 
kernels.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: multitouch: do not filter mice nodes
  HID: multitouch: add support for the Smart Tech panel

 drivers/hid/hid-multitouch.c | 37 +++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

-- 
2.19.2
