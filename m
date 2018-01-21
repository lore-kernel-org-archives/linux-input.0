From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input: da9034-ts: Adjustments for da9034_touch_probe()
Date: Sun, 21 Jan 2018 20:46:00 +0100
Message-ID: <44ae37ef-deaa-c963-e0f7-c407159afa0c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:50445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeAUTqD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 14:46:03 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:42:24 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/touchscreen/da9034-ts.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.0

