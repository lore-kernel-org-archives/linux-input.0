From: Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH 0/2] Input: drv266x: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 17:59:12 +0100
Message-ID: <1480438754-14794-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34097 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbcK2Q7i (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 11:59:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>

Hello,

This series fixes similar misues of the regmap_update_bits() API found
inside the drv2665.c and drv2667.c drivers. More details can be found
in the message of each patch.

Theses changes are not tested as I do not have the required hardware,
but the calls to regmap_update_bits() are clearly wrong in the current
code and the fix seems obvious. Any tests are warmly welcome.

Best regards,
Florian

Florian Vaussard (2):
  Input: drv2665: Fix misuse of regmap_update_bits
  Input: drv2667: Fix misuse of regmap_update_bits

 drivers/input/misc/drv2665.c | 5 +++--
 drivers/input/misc/drv2667.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.5.5

