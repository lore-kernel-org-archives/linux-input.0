From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Input: Fine-tuning for six function implementations
Date: Mon, 8 May 2017 15:03:33 +0200
Message-ID: <85bf6874-661a-9cab-1e9b-ea9e312b94de@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 8 May 2017 15:00:15 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use seq_putc() in input_seq_print_bitmap()
  Use seq_puts() in input_devices_seq_show()
  Improve a size determination in four functions

 drivers/input/input.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.12.2

