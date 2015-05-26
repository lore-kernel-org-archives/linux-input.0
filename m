From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern callbacks
Date: Tue, 26 May 2015 15:50:12 +0200
Message-ID: <CAPDyKFpbTx5rRuewziGzsqSHp1z7PO2-9VWV6DUTDytnWwUbpQ@mail.gmail.com>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
	<20150522143933.GI2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35995 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbbEZNuN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 09:50:13 -0400
Received: by qkx62 with SMTP id 62so88916627qkx.3
        for <linux-input@vger.kernel.org>; Tue, 26 May 2015 06:50:12 -0700 (PDT)
In-Reply-To: <20150522143933.GI2067@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org

On 22 May 2015 at 16:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
>> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > The legacy system PM support has long time ago been dropped from the
>> > AMBA bus. Align to that by converting to the modern system PM
>> > callbacks.
>> >
>> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> What happened with this one? Can we queue it for 4.2?
>
> Why does it have a Fixes: tag?  Is it fixing a real bug, or is it just
> fixing a warning that the kernel prints?

I would expect it to fix a real bug, but I am not able to test this on HW.

Since the commit 26825cfd90f9, the amba bus doesn't invoke the legacy
system PM callbacks any more. Instead it uses pm_generic_resume() as
its ->resume() callback which means amba_kmi_resume() won't be invoked
during system PM resume.

Kind regards
Uffe
