From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input-egalax_ts: Adjustments for egalax_ts_probe()
Date: Sun, 21 Jan 2018 19:49:07 +0100
Message-ID: <52f0c32d-2cf9-bef3-4fb3-4120c5b758c4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 19:46:54 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/touchscreen/egalax_ts.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.0

