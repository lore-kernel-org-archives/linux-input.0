From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] input: stmpe-ts: Use devm_*() routines
Date: Sat, 10 Nov 2012 13:34:33 +0530
Message-ID: <CAKohponupMgdMh8bvYaF+i9gRtwSJ9t4j+Gdy7mAieR8imc5Kw@mail.gmail.com>
References: <3d6f34ca5960203a5efb761f4d56b4e10ee24827.1352474824.git.viresh.kumar@linaro.org>
	<52b9fe53a8bd8dff7105209c5b1fab9da7a1510d.1352474824.git.viresh.kumar@linaro.org>
	<CAKohpomC1KTLk=UVim4gdYhJ5kngTZHOUvUgckD75AVH1w+FHw@mail.gmail.com>
	<20121110080009.GA12015@core.coreip.homeip.net>
	<CAKohponua2d95scdwmNsnVpG18nFYA1cuQa703kPfR7D8gF5fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45048 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2KJIEe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Nov 2012 03:04:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7009765iea.19
        for <linux-input@vger.kernel.org>; Sat, 10 Nov 2012 00:04:34 -0800 (PST)
In-Reply-To: <CAKohponua2d95scdwmNsnVpG18nFYA1cuQa703kPfR7D8gF5fg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com

On 10 November 2012 13:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10 November 2012 13:30, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> Sometimes your mailer does wrap long lines, please make sure to turn it
>> off for patches.
>
> I am using gmail for replying on mails and this fixup was done using that. Don't
> know why it happened.
>
> I am doing the same step again to verify what's playing with patches.
> On this copy
> i can see that this issue isn't there till now.
>
> diff --git a/drivers/input/touchscreen/stmpe-ts.c

> @@ -344,8 +344,6 @@ static int __devexit stmpe_ts_remove(struct
> platform_device *pdev)

wrapped again.. Don't know how to disable it. :(
