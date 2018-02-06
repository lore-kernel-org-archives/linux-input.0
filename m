From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HID-Asus: Adjustments for two function implementations
Date: Tue, 6 Feb 2018 18:28:51 +0100
Message-ID: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:24:56 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Return an error code only as a constant in asus_start_multitouch()

 drivers/hid/hid-asus.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.16.1

