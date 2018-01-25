From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Input: ims-pcu: Adjustments for three function
 implementations
Date: Thu, 25 Jan 2018 19:51:25 +0100
Message-ID: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:65266 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeAYSvk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 13:51:40 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 19:46:56 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in ims_pcu_buffers_alloc()
  Improve a size determination in two functions
  Delete an unnecessary variable assignment in ims_pcu_setup_gamepad()

 drivers/input/misc/ims-pcu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.16.1

