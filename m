From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] HID: logitech-dj: Adjustments for some function
 implementations
Date: Mon, 5 Feb 2018 22:24:40 +0100
Message-ID: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:39247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeBEVYw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Feb 2018 16:24:52 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:22:11 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in four functions
  Combine substrings for seven messages
  Fix a typo in a comment line

 drivers/hid/hid-logitech-dj.c | 53 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

-- 
2.16.1

