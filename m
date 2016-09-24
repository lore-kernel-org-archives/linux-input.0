From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] Input-gameport: Fine-tuning for joydump_connect()
Date: Sat, 24 Sep 2016 15:45:09 +0200
Message-ID: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 15:34:15 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Use kmalloc_array()
  Delete an error message for a failed memory allocation
  Add the macro "pr_fmt"
  Replace some printk() calls by pr_info()

 drivers/input/joystick/joydump.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

-- 
2.10.0
