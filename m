From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Input-apbps2: Adjustments for two function
 implementations
Date: Wed, 24 Jan 2018 17:33:43 +0100
Message-ID: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 17:30:12 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
  Improve a size determination
  Fix typos in a comment

 drivers/input/serio/apbps2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.16.1
