From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] input: cy8ctmg100_ts: signedness bug
Date: Thu, 5 Aug 2010 23:46:09 -0700
Message-ID: <20100806064609.GA27764@core.coreip.homeip.net>
References: <20100806063006.GM9031@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44043 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0HFGqO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 02:46:14 -0400
Content-Disposition: inline
In-Reply-To: <20100806063006.GM9031@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Aug 06, 2010 at 08:30:06AM +0200, Dan Carpenter wrote:
> "ret" should be signed here or the error handling doesn't work.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
> index 4eb7df0..f4e893f 100644
> --- a/drivers/input/touchscreen/cy8ctmg110_ts.c
> +++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
> @@ -96,7 +96,7 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
>  		unsigned char *data, unsigned char len, unsigned char cmd)
>  {
>  	struct i2c_client *client = tsc->client;
> -	unsigned int ret;
> +	int ret;
>  	struct i2c_msg msg[2] = {
>  		/* first write slave position to i2c devices */
>  		{ client->addr, 0, 1, &cmd },

Thanks Dan. It looks like cy8ctmg110_write_regs has siilar issue. Do you
thiks the following will work?

Thanks.

-- 
Dmitry

Input: cy8ctmg100_ts - signedness bug

From: Dan Carpenter <error27@gmail.com>

"ret" should be signed here or the error handling doesn't work.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cy8ctmg110_ts.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 4eb7df0..5ec0946 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -75,7 +75,7 @@ static int cy8ctmg110_write_regs(struct cy8ctmg110 *tsc, unsigned char reg,
 		unsigned char len, unsigned char *value)
 {
 	struct i2c_client *client = tsc->client;
-	unsigned int ret;
+	int ret;
 	unsigned char i2c_data[6];
 
 	BUG_ON(len > 5);
@@ -86,7 +86,7 @@ static int cy8ctmg110_write_regs(struct cy8ctmg110 *tsc, unsigned char reg,
 	ret = i2c_master_send(client, i2c_data, len + 1);
 	if (ret != 1) {
 		dev_err(&client->dev, "i2c write data cmd failed\n");
-		return ret;
+		return ret ? ret : -EIO;
 	}
 
 	return 0;
@@ -96,7 +96,7 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
 		unsigned char *data, unsigned char len, unsigned char cmd)
 {
 	struct i2c_client *client = tsc->client;
-	unsigned int ret;
+	int ret;
 	struct i2c_msg msg[2] = {
 		/* first write slave position to i2c devices */
 		{ client->addr, 0, 1, &cmd },
