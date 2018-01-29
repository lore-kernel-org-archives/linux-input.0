From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 0/8] Melfas MMS114 touchscreen cleanups
Date: Mon, 29 Jan 2018 20:33:15 +0900
Message-ID: <20180129113323.18961-1-andi.shyti@samsung.com>
References: <CGME20180129113330epcas2p353fa87845f4a1e21661032f16b11be82@epcas2p3.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31887 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeA2Ldd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 06:33:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Hi Dmitry,

this patchset contains some cleanups for the mms114 driver. The
first two patches are the most important because they get rid of
the custom i2c read/write functions and use the smbus instead.

The others come from a "cleanup rush" I felt into.

I tested the patchest on the mms114 touchscreen in trats2, I
would appreaciate if Simon can test it on mms152.

Thanks,
Andi

Andi Shyti (8):
  Input: mms114 - use smbus functions whenever possible
  Input: mms114 - get read of custm i2c read/write functions
  Input: mms114 - replace mdelay with msleep
  Input: mms114 - remove unused variable
  Input: mms114 - use lower case for hexadecimal values
  Input: mms114 - Use BIT() macro instead of explicit shifting
  Input: mms114 - add SPDX identifier
  Input: mms114 - fix typo in definition

 drivers/input/touchscreen/mms114.c | 150 +++++++++++--------------------------
 1 file changed, 44 insertions(+), 106 deletions(-)

-- 
2.15.1

