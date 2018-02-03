From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HID: N-Trig: Adjustments for ntrig_probe()
Date: Sat, 3 Feb 2018 21:56:22 +0100
Message-ID: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:64893 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbeBCU4c (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 15:56:32 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:54:32 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/hid/hid-ntrig.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.1

