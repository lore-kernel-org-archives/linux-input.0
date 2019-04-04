From: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 0/5] Input: Use devm_platform_ioremap_resource()
Date: Thu,  4 Apr 2019 12:47:18 +0530
Message-ID: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi All,

This is just a minor change to promote using of this api
devm_platform_ioremap_resource() and nothing else functional
change it does.

Also, there are patches where only ioremap is used without requesting
the mem region so this devm_platform_ioremap_resource() take cares all
of that in single call.


Mukesh Ojha (5):
  Input: fsl-imx25-tcq: Use devm_platform_ioremap_resource()
  Input: mxs-lradc-ts.c: Use devm_platform_ioremap_resource()
  Input: s3c2410_ts: Use devm_platform_ioremap_resource()
  Input: sun4i-ts: Use devm_platform_ioremap_resource()
  Input: ts4800-ts: Use devm_platform_ioremap_resource()

 drivers/input/touchscreen/fsl-imx25-tcq.c |  4 +---
 drivers/input/touchscreen/mxs-lradc-ts.c  |  6 +-----
 drivers/input/touchscreen/s3c2410_ts.c    | 10 +---------
 drivers/input/touchscreen/sun4i-ts.c      |  3 +--
 drivers/input/touchscreen/ts4800-ts.c     |  4 +---
 5 files changed, 5 insertions(+), 22 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
