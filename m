From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] Input: ims-pcu - fix typo in an error log
Date: Fri, 24 Nov 2017 15:49:58 +0800
Message-ID: <5A17CF26.5030003@huawei.com>
References: <1511506772-21412-1-git-send-email-thunder.leizhen@huawei.com>
 <1511507823.8230.8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:11415 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdKXHx5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 02:53:57 -0500
In-Reply-To: <1511507823.8230.8.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>



On 2017/11/24 15:17, Joe Perches wrote:
> On Fri, 2017-11-24 at 14:59 +0800, Zhen Lei wrote:
>> Tiny typo fixed in an error log.
>>
>> I found this when I backported the CVE-2017-16645 patch:
>> ea04efee7635 ("Input: ims-psu - check if CDC union descriptor is sane")
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/input/misc/ims-pcu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> []
>> @@ -1651,7 +1651,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
>>  				return union_desc;
>>
>>  			dev_err(&intf->dev,
>> -				"Union descriptor to short (%d vs %zd\n)",
>> +				"Union descriptor too short (%d vs %zd\n)",
> 
> And this format is incorrect too.  It should be:
> 
> +				"Union descriptor too short (%d vs %zd)\n",
> 
> with the close parenthesis before the newline, not after.
You are very observant. Do I need to post v2? It seems that we can simply modify it directly.

> 
> 
> .
> 

-- 
Thanks!
BestRegards

