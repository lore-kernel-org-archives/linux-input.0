From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [Y2038] [PATCH] hp_sdc: fixed y2038 problem
Date: Wed, 21 Oct 2015 16:52:16 +0800
Message-ID: <56275240.5040907@linaro.org>
References: <1445161459-26918-1-git-send-email-pingbo.wen@linaro.org>
 <5041745.xAgMz1TQSE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34009 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbJUIwW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 04:52:22 -0400
Received: by padhk11 with SMTP id hk11so49093159pad.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2015 01:52:22 -0700 (PDT)
In-Reply-To: <5041745.xAgMz1TQSE@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org



On Monday, October 19, 2015 05:01 PM, Arnd Bergmann wrote:
> On Sunday 18 October 2015 17:44:19 WEN Pingbo wrote:
>> Two replacements happened in this patch:
>>     1. using timespec64 to prevent time overflow in 2038
>>     2. using ktime_get_ts64 to avoid wall time issues(leap second, etc)
>>
>> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
>>
> 
> The patch looks correct, but I think this could be written a little
> simpler and clearer using ktime_get() or ktime_getns().
> 

That make sense, Maybe it can save a sec shift operation. I will check it later.

Pingbo
