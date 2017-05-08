From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] Input: Use seq_putc() in input_seq_print_bitmap()
Date: Mon, 8 May 2017 15:04:36 +0200
Message-ID: <7f53f603-1069-1e7a-67b6-78f8009aa0c1@users.sourceforge.net>
References: <85bf6874-661a-9cab-1e9b-ea9e312b94de@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85bf6874-661a-9cab-1e9b-ea9e312b94de@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 8 May 2017 14:20:18 +0200

A single character should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 067d648028a2..0d204b841575 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1126,7 +1126,7 @@ static void input_seq_print_bitmap(struct seq_file *seq, const char *name,
 	 * If no output was produced print a single 0.
 	 */
 	if (skip_empty)
-		seq_puts(seq, "0");
+		seq_putc(seq, '0');
 
 	seq_putc(seq, '\n');
 }
-- 
2.12.2
