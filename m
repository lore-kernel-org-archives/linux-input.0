From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 0/5] use managed functions for ad7897 driver
Date: Thu,  2 Nov 2017 17:01:31 +0200
Message-ID: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:33868 "EHLO
        3.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933658AbdKBPiU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 11:38:20 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id D36F99A697
        for <linux-input@vger.kernel.org>; Thu,  2 Nov 2017 16:01:54 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

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

Andi Shyti (5):
  Input: ad7897 - use managed devm_kzalloc
  Input: ad7897 - use managed devm_input_allocate_device
  Input: ad7897 - use managed devm_request_threaded_irq
  Input: ad7897 - use managed devm_device_add_group
  Input: ad7897 - use separate error handling for different allocators

 drivers/input/touchscreen/ad7877.c | 45 +++++++++++---------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

-- 
2.15.0

