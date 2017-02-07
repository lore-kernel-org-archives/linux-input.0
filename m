From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: synaptics-rmi4 - fix error return code in rmi_probe_interrupts()
Date: Tue,  7 Feb 2017 14:52:25 +0000
Message-ID: <20170207145225.31228-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33112 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbdBGOwj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 09:52:39 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so9462923pfg.0
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2017 06:52:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -ENOMEM from the devm_kzalloc() error handling
case instead of 0, as done elsewhere in this function.

Fixes: 6bd0dcfacf28 ("Input: synaptics-rmi4 - factor out functions
from probe")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index bf5c36e..0c54446 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1049,7 +1049,7 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 	data->irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
 	if (!data->irq_memory) {
 		dev_err(dev, "Failed to allocate memory for irq masks.\n");
-		return retval;
+		return -ENOMEM;
 	}
 
 	data->irq_status	= data->irq_memory + size * 0;

