From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] HID: cp2112: fix sleep-while-atomic regression
Date: Mon, 30 Jan 2017 11:22:33 +0100
Message-ID: <20170130102235.3691-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

These patches fix a sleep-while-atomic and an error-handling issue
introduced by a patch that went into 4.9.

Note that this series has only been compile tested.

Johan


Johan Hovold (2):
  HID: cp2112: fix sleep-while-atomic
  HID: cp2112: fix gpio-callback error handling

 drivers/hid/hid-cp2112.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

-- 
2.10.2
