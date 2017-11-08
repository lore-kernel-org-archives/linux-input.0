From: Andi Shyti <andi@etezian.org>
Subject: [PATCH v3 0/3] use managed functions for ad7897 driver
Date: Wed,  8 Nov 2017 17:50:17 +0200
Message-ID: <20171108155020.3851-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:34170 "EHLO
        9.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdKHPue (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Nov 2017 10:50:34 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0B98116E8CE
        for <linux-input@vger.kernel.org>; Wed,  8 Nov 2017 16:50:33 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Hi Dmitry,

after our discussion[1], I decided to do it a more properly by
replacing in the touchscreen drivers the initialization functions
with their related managed functions.

I will slowly send patches for other drivers.

The last patch is trivial, but somehow it bothers me, please feel
free to reject it.

Thanks,
Andi

v2 - v3
https://marc.info/?l=linux-kernel&m=151015103707211&w=2
 - fixed a mistake I did while squashing the patches in v2
   (thanks Lars[2])

v1 - v2
https://marc.info/?l=linux-kernel&m=150963732620135&w=2
 - squashed all the patches that were switching to the managed
   resource allocation
 - removed the remove() function and used
   devm_add_action_or_reset for cleaning when exiting

[1] https://marc.info/?l=linux-input&m=150671805312148&w=2
[2] https://marc.info/?l=linux-kernel&m=151015513508504&w=2

Andi Shyti (3):
  Input: ad7897 - use managed allocated resources
  Input: ad7897 - use devm_add_action_or_reset to disable the device
  Input: ad7897 - use separate error handling for different allocators

 drivers/input/touchscreen/ad7877.c | 65 ++++++++++++--------------------------
 1 file changed, 20 insertions(+), 45 deletions(-)

-- 
2.15.0

