From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] HID-Wacom: Fine-tuning for seven function implementations
Date: Tue, 25 Apr 2017 17:12:41 +0200
Message-ID: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2017 17:07:07 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use devm_kcalloc() in two functions
  Improve size determinations in three functions
  Delete two unnecessary return statements

 drivers/hid/wacom_sys.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.12.2

