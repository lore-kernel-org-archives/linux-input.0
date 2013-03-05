From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 8/8] Input: atmel-wm97xx: Use module_platform_driver_probe macro
Date: Tue, 5 Mar 2013 09:17:27 +0530
Message-ID: <CAK9yfHx-v0B=QXvTzGUndDMroQg3nD8artGFOxfXCKf7u_P+8w@mail.gmail.com>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
	<1362453827-18129-8-git-send-email-sachin.kamat@linaro.org>
	<20130305033606.GC9391@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:49958 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758759Ab3CEDr1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:47:27 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so10053622oag.39
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:47:27 -0800 (PST)
In-Reply-To: <20130305033606.GC9391@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On 5 March 2013 09:06, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 05, 2013 at 08:53:47AM +0530, Sachin Kamat wrote:
>> module_platform_driver_probe() eliminates the boilerplate and simplifies
>> the code.
>
> Is there really any great reason to use this as opposed to
> module_platform_driver()?

Since the init function returns platform_driver_probe() instead of
platform_driver_register(), I have used module_platform_driver_probe()
macro.

>I know the existing code does this, it's not
> clear to me that that's a good idea either.

However, if your question is why return platform_driver_probe() at all
instead of platform_driver_register() in the first place, then I am
sorry I do not have much idea about it.
