From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Input-bcm5974: Adjustments for two function
 implementations
Date: Wed, 24 Jan 2018 21:29:00 +0100
Message-ID: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:56296 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeAXU3G (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 15:29:06 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:25:24 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in bcm5974_wellspring_mode()
  Return directly after a failed kmalloc() in bcm5974_wellspring_mode()
  Improve a size determination in bcm5974_probe()

 drivers/input/mouse/bcm5974.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.16.1

