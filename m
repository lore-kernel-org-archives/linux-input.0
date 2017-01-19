From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 13/33] Input: bfin_rotary - Use 'dev' instead of
 dereferencing it and other changes
Date: Thu, 19 Jan 2017 00:25:45 -0800
Message-ID: <3e4f803b-9416-e7fc-a001-16d4a5850e84@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-14-git-send-email-linux@roeck-us.net>
 <20170118193952.GG33920@dtor-ws> <20170118203517.GB6807@roeck-us.net>
 <1484801932.18392.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50155 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdASI0N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 03:26:13 -0500
In-Reply-To: <1484801932.18392.1.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2017 08:58 PM, Joe Perches wrote:
> On Wed, 2017-01-18 at 12:35 -0800, Guenter Roeck wrote:
>> On Wed, Jan 18, 2017 at 11:39:52AM -0800, Dmitry Torokhov wrote:
>>> On Wed, Jan 18, 2017 at 09:46:34AM -0800, Guenter Roeck wrote:
> []
>>>> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> []
>>>> @@ -141,25 +141,23 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>>>>
>>>>  	/* Basic validation */
>>>>  	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
>>>> -	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
>>>> +	    (!pdata->rotary_up_key && pdata->rotary_down_key))
>
> maybe just use ^
>
> 	if (!pdata->rotary_up_key ^ !pdata->rotary_down_key)
>
Interesting use case for a coccinelle rule.

To address the coccinelle related problem, I modified the rule to only apply
if the expression is in one line, and if the return statement is in the next
line. That works pretty well.

Guenter

