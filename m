From: yegorslists@googlemail.com
Subject: [PATCH v2 0/3] Add DT support for tps6507x touchscreen
Date: Thu,  9 Mar 2017 15:31:06 +0100
Message-ID: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33941 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbdCIOcH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 09:32:07 -0500
Received: by mail-wr0-f178.google.com with SMTP id l37so46262746wrc.1
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 06:31:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, nsekhar@ti.com, khilman@baylibre.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This is an attempt to revive DT support for TI tps6507x that was started
in 2013 [1], [2].

Changes since V2:
 - use devm_input_allocate_polled_device and remove tps6507x_ts_remove
 - device_property_read_* API to get poll_interval and min_pressure
 - remove id values from DT and make them static

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

 Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++-
 drivers/input/touchscreen/tps6507x-ts.c            | 71 ++++++----------------
 2 files changed, 31 insertions(+), 56 deletions(-)

-- 
2.1.4

