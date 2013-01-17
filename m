From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v3] Input: mms114: Use devm_* APIs
Date: Thu, 17 Jan 2013 14:13:54 +0530
Message-ID: <CAK9yfHw3zMUNA3g4=6h0QxpOT0bP1LfdTNxe6gEBOfbGwoh8Jg@mail.gmail.com>
References: <1357723353-11144-1-git-send-email-sachin.kamat@linaro.org>
	<50ED3CC0.10302@nvidia.com>
	<20130109170549.GA7564@core.coreip.homeip.net>
	<CAK9yfHx+YqmoQ6qyDjdhu=dGrkMi_3kSjP+dVAYxAWwj0e-=jQ@mail.gmail.com>
	<20130117083048.GA15384@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33650 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3AQInz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 03:43:55 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so2409506oag.34
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 00:43:54 -0800 (PST)
In-Reply-To: <20130117083048.GA15384@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 17 January 2013 14:00, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Jan 17, 2013 at 08:28:15AM +0530, Sachin Kamat wrote:
>> Hi Dmitry,
>>
>> On 9 January 2013 22:35, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Jan 09, 2013 at 03:17:44PM +0530, Laxman Dewangan wrote:
>> >> On Wednesday 09 January 2013 02:52 PM, Sachin Kamat wrote:
>> >> >devm_* APIs are device managed and make the exit and clean up code
>> >> >simpler.
>> >> >
>> >> >Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >> >Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> >> >---
>> >>
>> >> Acked-by: Laxman Dewangan<ldewangan@nvidia.com>
>> >>
>> >
>> > Applied, thank you.
>>
>> I did not find this patch in your tree at [1].
>> Or did I look in the wrong place?
>>
>> [1] http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=shortlog;h=refs/heads/next
>
> No, apparently I forgot to push my branch out. Should be there now.

Yes I can see it now. Thanks.


>
> --
> Dmitry



-- 
With warm regards,
Sachin
