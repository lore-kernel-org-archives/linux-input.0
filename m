From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 22:30:02 +0100
Message-ID: <570822DA.9090203@itdev.co.uk>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
 <5707756E.30506@itdev.co.uk> <20160408121418.GT23166@bill-the-cat>
 <5707A376.2080404@itdev.co.uk> <20160408123913.GV23166@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:58289 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758973AbcDHVaA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2016 17:30:00 -0400
In-Reply-To: <20160408123913.GV23166@bill-the-cat>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On 2016-04-08 13:39, Tom Rini wrote:
>>>> I have a Pixel 2 here - can you advise how to reproduce?
>>>
>>> I (and a bunch of other folks, the linux-samus people now point people
>>> at using mxt-app every boot to reset the device) see this every time I
>>> either suspend the laptop or do a warm boot into a new kernel (I didn't
>>> try kexec but it too is probably broken).  Note that I'm not using
>>> mainline to boot ChromeOS but I've got a regular Linux distro in ROOT-C.
>>
>> OK. I will try it. My Pixel is running Ubuntu with a mainline kernel, so
>> should be able to repro.
> 
> Thanks.  Happy to test patches when you get there and feel free to shoot
> me patches to have more info get dumped out or whatever if needed.

Could you try the below patch to correctly acquire the IRQ after soft reset on
systems using IRQF_TRIGGER_FALLING.

Appears to work correctly on my Pixel 2 during a brief test.

A workaround also seems to be to reconfig T18 COMMSCONFIG to enable
the RETRIGEN bit using mxt-app:
    mxt-app -W -T18 44
    mxt-app --backup
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2160512e..5af7907 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1093,6 +1093,19 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset,
 	return 0;
 }
 
+static int mxt_acquire_irq(struct mxt_data *data)
+{
+	int error;
+
+	enable_irq(data->irq);
+
+	error = mxt_process_messages_until_invalid(data);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static int mxt_soft_reset(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -1111,7 +1124,7 @@ static int mxt_soft_reset(struct mxt_data *data)
 	/* Ignore CHG line for 100ms after reset */
 	msleep(100);
 
-	enable_irq(data->irq);
+	mxt_acquire_irq(data);
 
 	ret = mxt_wait_for_completion(data, &data->reset_completion,
 				      MXT_RESET_TIMEOUT);
@@ -1466,19 +1479,6 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	return ret;
 }
 
-static int mxt_acquire_irq(struct mxt_data *data)
-{
-	int error;
-
-	enable_irq(data->irq);
-
-	error = mxt_process_messages_until_invalid(data);
-	if (error)
-		return error;
-
-	return 0;
-}
-
 static int mxt_get_info(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
