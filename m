From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/3] HID: multitouch: fix a corner case of some Win 8 devices
Date: Thu, 15 Jun 2017 15:32:02 +0200
Message-ID: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Arek Burdach <arek.burdach@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

It looks like the Microsft certification misses one case of released fingers.

The (only) solution we can have against that is to wait for a hundred of ms,
and if no input report comes in, consider that the touches should have been
released. The spec, as I read it, enforces that.

Arek, can you please give a test to this new series?
I managed to find out a way to have the IRQ and the timeout exclusive, and
also added a few optimizations.

Cheers,
Benjamin

Benjamin Tissoires (3):
  HID: multitouch: use BIT macro
  HID: multitouch: fix rare Win 8 cases when the touch up event gets
    missing
  HID: multitouch: optimize the sticky fingers timer

 drivers/hid/hid-multitouch.c | 149 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 39 deletions(-)

-- 
2.9.4
