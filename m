From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 2/4] input: Convert struct i2c_msg initialization to C99 format
Date: Wed, 10 Oct 2012 17:05:39 +0530
Message-ID: <CAM=Q2ctFe29-Dyi+jn6s=-ybQBzXoNERSXeXCQwSCsKUAv8=XA@mail.gmail.com>
References: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
	<1349782278-9023-2-git-send-email-shubhrajyoti@ti.com>
	<20121010110228.3cbccde3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53550 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2JJLfk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 07:35:40 -0400
In-Reply-To: <20121010110228.3cbccde3@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, Oct 10, 2012 at 2:32 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 9 Oct 2012 17:01:18 +0530, Shubhrajyoti D wrote:
[...]
>
> Acked-by: Jean Delvare <khali@linux-fr.org>


thanks updated patch below
>From 6638ecfa7982f95815382922c50573712c9626d7 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Mon, 17 Sep 2012 19:37:17 +0530
Subject: [PATCHv2 1/2] input: Convert struct i2c_msg initialization to C99
 format

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion

Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c
b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 464f1bf..ad6a664 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -99,9 +99,18 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
 	int ret;
 	struct i2c_msg msg[2] = {
 		/* first write slave position to i2c devices */
-		{ client->addr, 0, 1, &cmd },
+		{
+			.addr = client->addr,
+			.len = 1,
+			.buf = &cmd
+		},
 		/* Second read data from position */
-		{ client->addr, I2C_M_RD, len, data }
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = data
+		}
 	};

 	ret = i2c_transfer(client->adapter, msg, 2);
-- 
1.7.5.4
