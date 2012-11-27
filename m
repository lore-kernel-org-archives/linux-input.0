From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2] Input: samsung-keypad - Use devm_* functions
Date: Tue, 27 Nov 2012 15:54:56 +0530
Message-ID: <CAK9yfHwD2gv-F1uMXHtdDTY-OpC-UAnmJC1+LS9fvUMjzbVbxg@mail.gmail.com>
References: <1354010091-31294-1-git-send-email-sachin.kamat@linaro.org>
	<20121127101320.GD25658@core.coreip.homeip.net>
	<20121127101422.GE25658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40438 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab2K0KY6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 05:24:58 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6657810vbb.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 02:24:57 -0800 (PST)
In-Reply-To: <20121127101422.GE25658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@linaro.org, Kukjin Kim <kgene.kim@samsung.com>

On 27 November 2012 15:44, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 27, 2012 at 02:13:21AM -0800, Dmitry Torokhov wrote:
>> On Tue, Nov 27, 2012 at 03:24:51PM +0530, Sachin Kamat wrote:
>> > devm_* functions are device managed and make error handling
>> > and code simpler. While at it also fix error exit paths.
>> >
>>
>> Is this different from the version I sent you?
>
> Ahh,, I see, there was a typo with extra 'i'... Anything else?

No. Just rebased it on top of latest next and updated the commit message a bit.
>
> Thanks.
>
> -
> Dmitry



-- 
With warm regards,
Sachin
