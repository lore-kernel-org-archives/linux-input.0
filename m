From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend] Input: tegra-kbc- Convert to devm_ioremap_resource()
Date: Mon, 25 Feb 2013 12:22:20 +0530
Message-ID: <CAK9yfHzo7bDP7wXmuV3Hwxr4d1FYcJ-mT2MdPyXFFpO9VW876g@mail.gmail.com>
References: <1361764020-28728-1-git-send-email-sachin.kamat@linaro.org>
	<20130225064808.GB3735@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:51305 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3BYGwV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 01:52:21 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so2510748obh.2
        for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 22:52:20 -0800 (PST)
In-Reply-To: <20130225064808.GB3735@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, thierry.reding@avionic-design.de

On 25 February 2013 12:18, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Mon, Feb 25, 2013 at 09:17:00AM +0530, Sachin Kamat wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> devm_ioremap_resource() provides its own error messages; so all explicit
>> error messages can be removed from the failure code paths.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
>> ---
>> Rebased on the latest Linus' tree (v3.8+).
>
> I do not have this yet. I will merge with mainline around rc3, please
> ping me then.
>

OK. I will ping you later.

-- 
With warm regards,
Sachin
