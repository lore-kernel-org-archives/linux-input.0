From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Tue, 16 Dec 2014 18:46:19 +0100
Message-ID: <54906FEB.7060702@collabora.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk> <54905AD7.4070205@itdev.co.uk> <54905F00.4020107@collabora.co.uk> <54906031.8020309@itdev.co.uk> <54906285.3060907@collabora.co.uk> <549066D4.7000302@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39454 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaLPRq2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 12:46:28 -0500
In-Reply-To: <549066D4.7000302@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hello Nick,

On 12/16/2014 06:07 PM, Nick Dyer wrote:
> On 16/12/14 16:49, Javier Martinez Canillas wrote:
>> Awesome, what do you think about the change to have a common input device
>> initialization function that I squashed in your original patch?
>> mxt_initialize_t100_input_device() and mxt_initialize_t9_input_device()
>> are very similar so I think that is a sensible refactoring as well.
>> 
>> If you agree with the change I can post it on top of your patch once it
>> lands in mainline.
> 
> I had been keeping them separate on the basis that we don't want changes to
> support new T100 features to cause regressions in the old T9 handling. But
> there is a fair amount of duplication as you say, probably worth addressing.
>

Yeah but if there are regressions I think we should address those instead of
duplicating code, to make the driver more maintainable in the long term.

> FWIW I have a queue of stuff that might be considered higher priority, the
> next 15-patch set would be up to "add regulator control support":
> https://github.com/ndyer/linux/compare/dtor:next...for-dtor
> 
> It does cause me some issues to merge upstream refactorings past that lot...
> 

Sure, I can hold any refactoring patches until you have pushed all your
queue so you don't have to resolve conflicts. 

Just let me know when is a good time to push the refactoring changes.

Thanks a lot for your help and best regards,
Javier
