From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] MMS114 touchscreen patches
Date: Wed, 24 Jan 2018 11:38:00 -0800
Message-ID: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46155 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeAXTiI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 14:38:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>
Cc: Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

This is a combination of couple of my patches + Simons patches dropping
support for platform data and adding support for mms152, slightly reworked.

Andi, because patches changed a bit I did not add your reviewed-by or
tested-by, please take another look.

Thanks!

Dmitry Torokhov (2):
  Input: mms114 - do not clobber interrupt trigger
  Input: mms114 - mark as direct input device

Simon Shields (2):
  Input: mms114 - drop platform data and use generic APIs
  Input: mms114 - add support for mms152

 .../bindings/input/touchscreen/mms114.txt          |  35 ++--
 drivers/input/touchscreen/mms114.c                 | 229 ++++++++++++---------
 include/linux/platform_data/mms114.h               |  24 ---
 3 files changed, 151 insertions(+), 137 deletions(-)
 delete mode 100644 include/linux/platform_data/mms114.h

-- 
Dmitry

