From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 0/3] Input: goodix - fixes and conversion to touchscreen_properties
Date: Tue, 14 Nov 2017 13:42:14 +0100
Message-ID: <20171114124217.2863-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:32806 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbdKNMm2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 07:42:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>

Hi,

This patch series originates from single patch [1], which is now patch
number 3. Fixes for swapping inverted axis and reporting supported range
are now moved to separate patches (1 and 2 in series), which make it
possible to backport these fixes to stable kernel releases.

Patches were developed and tested on kernel/git/dtor/input.git next
branch.

[1] https://www.spinics.net/lists/linux-input/msg53698.html

Marcin Niestroj (3):
  Input: goodix - fix reported range
  Input: goodix - fix simultaneous axes inversion and swap
  Input: goodix - use generic touchscreen_properties

 drivers/input/touchscreen/goodix.c | 87 +++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

-- 
2.15.0

