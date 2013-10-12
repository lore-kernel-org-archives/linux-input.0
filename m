From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: nspire-keypad - add missing clk_disable_unprepare() on
 error path
Date: Sat, 12 Oct 2013 14:32:09 +0800
Message-ID: <CAPgLHd9f_4-mtxXKLcL+fiNJw8gdTjU8ZSJtJoSLTW2tSa-N_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:50581 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3JLGcK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Oct 2013 02:32:10 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so1876410bkb.2
        for <linux-input@vger.kernel.org>; Fri, 11 Oct 2013 23:32:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, dt.tangr@gmail.com, yongjun_wei@trendmicro.com.cn, Julia.Lawall@lip6.fr, viresh.kumar@linaro.org
Cc: linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return
from nspire_keypad_open() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/keyboard/nspire-keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index b3e3eda..85e8d80 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -143,8 +143,10 @@ static int nspire_keypad_open(struct input_dev *input)
 		return error;
 
 	error = nspire_keypad_chip_init(keypad);
-	if (error)
+	if (error) {
+		clk_disable_unprepare(keypad->clk);
 		return error;
+	}
 
 	return 0;
 }

