From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Mon, 04 Jul 2011 15:42:55 +0300
Message-ID: <4E11B54F.3010702@atmel.com>
References: <4E11825B.3000409@atmel.com> <20110704100435.GA3723@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:50851 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab1GDM6N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 08:58:13 -0400
In-Reply-To: <20110704100435.GA3723@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On 07/04/2011 01:04 PM, Dmitry Torokhov wrote:
>>  
>> @@ -828,6 +828,8 @@ static int mxt_initialize(struct mxt_data *data)
>>  	mxt_write_object(data, MXT_GEN_COMMAND,
>>  			MXT_COMMAND_RESET, 1);
>>  	msleep(MXT_RESET_TIME);
>> +	while (data->pdata->read_chg())
>> +		msleep(2);
> 
> I would prefer if we did not wait indefinitely but timed out after
> certain number of retries.
> 

Thanks, that does make sense. I'll send a new version.


BR,

-- 
Iiro
