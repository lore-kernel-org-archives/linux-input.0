From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 0/2] Licensing fixes and updates for the mms114 driver
Date: Thu, 01 Feb 2018 17:23:18 +0900
Message-ID: <20180201082320.24031-1-andi.shyti@samsung.com>
References: <CGME20180201082338epcas1p43bf7d96c63fdc5bf905528e45d227d8b@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I will send this two as a new patchset. The first one is the
messed SPDX patch that you reverted, the second one is about the
license incohorency that Marcus has pointed out.

Andi

Andi Shyti (2):
  Input: mms114 - add SPDX identifier
  Input: mms114 - fix license module information

 drivers/input/touchscreen/mms114.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.15.1
