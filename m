From: Andi Shyti <andi@etezian.org>
Subject: [PATCH v2 0/3] use managed functions for ad7897 driver
Date: Wed,  8 Nov 2017 16:04:00 +0200
Message-ID: <20171108140403.727-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

after our discussion[*], I decided to do it a more properly by
replacing in the touchscreen drivers the initialization functions
with their related managed functions.

I will slowly send patches for other drivers.

The last patch is trivial, but somehow it bothers me, please feel
free to reject it.

Thanks,
Andi

[*] https://marc.info/?l=linux-input&m=150671805312148&w=2

v1 - v2
https://marc.info/?l=linux-kernel&m=150963732620135&w=2

 - squashed all the patches that were switching to the managed
   resource allocation
 - removed the remove() function and used
   devm_add_action_or_reset for cleaning when exiting

Andi Shyti (3):
  Input: ad7897 - use managed allocated resources
  Input: ad7897 - use devm_add_action_or_reset to disable the device
  Input: ad7897 - use separate error handling for different allocators

 drivers/input/touchscreen/ad7877.c | 65 ++++++++++++--------------------------
 1 file changed, 20 insertions(+), 45 deletions(-)

-- 
2.15.0
