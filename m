From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input: auo-pixcir-ts: Adjustments for two function
 implementations
Date: Sun, 21 Jan 2018 22:14:15 +0100
Message-ID: <df18b548-f95e-e315-9e77-f379af7909e8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:52414 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeAUVOZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 16:14:25 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 22:10:44 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
    in auo_pixcir_parse_dt()
  Delete an unnecessary return statement in auo_pixcir_input_close()

 drivers/input/touchscreen/auo-pixcir-ts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.16.0

