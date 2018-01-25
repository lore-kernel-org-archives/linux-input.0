From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input-da9063_onkey: Adjustments for da9063_onkey_probe()
Date: Thu, 25 Jan 2018 20:34:29 +0100
Message-ID: <9b0e8f6a-6386-d307-34fc-7936c52bd0c6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:61918 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbeAYTed (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 14:34:33 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, support.opensource@diasemi.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 20:30:40 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/misc/da9063_onkey.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.1

