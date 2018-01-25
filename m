From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v3 0/3] Input: goodix - fixes and conversion to touchscreen_properties
Date: Thu, 25 Jan 2018 20:08:26 +0100
Message-ID: <20180125190829.8968-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:58631 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeAYTdm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 14:33:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>

Hi,

In this patch series I have only improved / fixed commit descriptions.

In comments of v2 patch series [1] there was a question if we should
left these 3 patches separate or meld them together. However there was
no decision made, so I've kept them separate for now. That way patches
1 and 2 can be easily backported to stable releases.

Patches were rebased and tested on v4.15-rc9.

[1] https://www.spinics.net/lists/linux-input/msg53976.html

Marcin Niestroj (3):
  Input: goodix - fix reported range
  Input: goodix - fix simultaneous axes inversion and swap
  Input: goodix - use generic touchscreen_properties

 drivers/input/touchscreen/goodix.c | 87 +++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

-- 
2.16.1

