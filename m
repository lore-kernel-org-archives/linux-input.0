From: yegorslists@googlemail.com
Subject: [PATCH 0/3] Add DT support for tps6507x touchscreen
Date: Fri, 24 Feb 2017 16:42:23 +0100
Message-ID: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35914 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdBXPms (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2017 10:42:48 -0500
Received: by mail-wr0-f170.google.com with SMTP id 89so15532316wrr.3
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2017 07:42:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This is an attempt to revive DT support for TI tps6507x that was started
in 2013 [1], [2].

Current changes:
 - remove tsc node
 - add /bits/ 16 to for 16-bit values
 - rework bindings description, i.e. all properties are optional

Histor of original changes:

Changes since V3:
 - Rebased on top of Dmitry's changes
 - Removed error handling for optional DT properties

Changes since V2:
 - Updated tps6507x documentation.
 - Removed unnecessary code.

Changes since V1:
 - Updated tps6507x documentation.
 - Updated commit message.
 - return proper error value in absence platform and DT data
   for touchscreen.

[1] https://www.spinics.net/lists/devicetree/msg09388.html
[2] https://patchwork.kernel.org/patch/2324441/

Yegor Yefremov (3):
  tps6507x-ts: update to devm_* API
  tps6507x-ts: add DT support
  tps6507x-ts: add DT bindings description

 Documentation/devicetree/bindings/mfd/tps6507x.txt | 30 +++++++-
 drivers/input/touchscreen/tps6507x-ts.c            | 79 ++++++++++++----------
 2 files changed, 73 insertions(+), 36 deletions(-)

-- 
2.1.4

