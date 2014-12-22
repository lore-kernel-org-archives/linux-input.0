From: Daniele Forsi <dforsi@gmail.com>
Subject: [RFC PATCH 0/2] USB: input: yealink.c: update key mappings
Date: Mon, 22 Dec 2014 15:41:07 +0100
Message-ID: <1419259269-23820-1-git-send-email-dforsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henk Vergonet <Henk.Vergonet@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: usbb2k-api-dev@nongnu.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

I have an Yealink USB phone which is handled by the yealink.c driver but the
'#' key returns an unexpected value and keys labeled "RING" and "MUTE" do not
return any value to userspace.

In the first patch of this series I replace the combination KEY_LEFTSHIFT and
KEY_3 with KEY_NUMERIC_POUND and I also replace other keys for internal consistency
and with the cm109.c driver, which according to the comment in the code is derived
from this one, is this the right approach?

In the second patch I add two additional keys which could be handled by userspace:
 "RING" whose purpose according to the user manual is to cycle all available ringtones
 "MUTE" whose purpose is to mute the USB microphone
which KEY_* values should be used for them?

I have two more questions:
DRIVER_VERSION should be updated?
are both patches suitable for stable?

Daniele Forsi (2):
  USB: input: yealink.c: use KEY_NUMERIC_* for numeric keys, star and
    pound
  USB: input: yealink.c: add mapping for "RING" and "MUTE" keys

 drivers/input/misc/yealink.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

-- 
2.1.3
