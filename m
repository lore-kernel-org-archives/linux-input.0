From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add generic platform data for
 Chromebooks
Date: Tue, 1 Dec 2015 18:25:15 -0300
Message-ID: <565E103B.6050103@osg.samsung.com>
References: <20151124185810.GA18357@dtor-ws>
 <5654B7ED.9080107@osg.samsung.com> <20151201212151.GC3740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46729 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbbLAVZZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Dec 2015 16:25:25 -0500
In-Reply-To: <20151201212151.GC3740@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org

Hello Dmitry,

On 12/01/2015 06:21 PM, Dmitry Torokhov wrote:

[snip]

>>>  
>>> +static unsigned int chromebook_tp_buttons[] = {
>>
>> Maybe naming it chromebook_t19_buttons instead to make it clear that the
>> mapping is specific to the T19 object or at least document that assumption?
> 
> The idea was to document that the mapping is applied to the touchpad
> and not any other Atmel device that might have T19 object in it, similar
> to samus_touchpad_buttons[] array.
>

You are right, the naming makes sense then indeed.

Thanks a lot for the explanation.
 
>>
>> Although is mentioned in the commit message so I don't have a strong
>> preference and the patch looks good to me:
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Thank you for the review.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
