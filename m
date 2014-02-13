From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/4] input: sirfsoc-onkey - a bundle of minor clean or fix
Date: Thu, 13 Feb 2014 14:40:20 +0800
Message-ID: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:45431 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaBMGkt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:40:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so10341472pab.12
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:40:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

Hi Dmitry,
this patchset depends on Xianglong's
"[PATCH v2] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status"

Barry Song (2):
  input: sirfsoc-onkey - drop the IRQF_SHARED flag
  input: sirfsoc-onkey - update copyright years to 2014

Xianglong Du (2):
  input: sirfsoc-onkey - namespace pwrc_resume function
  input: sirfsoc-onkey - use dev_get_drvdata instead of
    platform_get_drvdata

 drivers/input/misc/sirfsoc-onkey.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.5.4

