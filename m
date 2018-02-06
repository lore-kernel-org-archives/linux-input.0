From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] HID-Lenovo: Adjustments for three function
 implementations
Date: Tue, 6 Feb 2018 17:14:51 +0100
Message-ID: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:51085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeBFQPA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Feb 2018 11:15:00 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:12:34 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in lenovo_probe_tpkbd()
  Adjust four checks for null pointers

 drivers/hid/hid-lenovo.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.16.1

