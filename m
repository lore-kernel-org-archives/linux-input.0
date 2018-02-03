From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/6] HID-Prodikeys: Adjustments for two function
 implementations
Date: Sat, 3 Feb 2018 18:36:46 +0100
Message-ID: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeBCRgz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 12:36:55 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:21:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  Delete two error messages for a failed memory allocation in pk_probe()
  Delete an unnecessary variable initialisation in pk_probe()
  Move an assignment in pk_probe()
  Delete an unnecessary return statement in pcmidi_send_note()
  Combine two condition checks into one statement in pcmidi_send_note()
  Rename a jump label in pcmidi_send_note()

 drivers/hid/hid-prodikeys.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

-- 
2.16.1

