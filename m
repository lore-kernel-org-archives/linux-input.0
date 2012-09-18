From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between DT
 and non-DT boots
Date: Tue, 18 Sep 2012 13:22:06 +0200
Message-ID: <CACRpkdbntZ2k+2mi7=nCL2RV+YcbYi=wbK2RaDKsKNKqsCxMOA@mail.gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
	<CACRpkdaKa=NAObnjJyifhxyqu3Hcgj7Fxqi=bdNFqbm7V_8cSw@mail.gmail.com>
	<20120914080347.GB3374@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52665 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757998Ab2IRLWH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 07:22:07 -0400
Received: by weyx8 with SMTP id x8so4487446wey.19
        for <linux-input@vger.kernel.org>; Tue, 18 Sep 2012 04:22:06 -0700 (PDT)
In-Reply-To: <20120914080347.GB3374@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: arnd@arndb.de, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, linux-input@vger.kernel.org

On Fri, Sep 14, 2012 at 10:03 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, Sep 13, 2012 at 11:35:43AM +0200, Linus Walleij wrote:
>>
>> Not having this patch in v3.6-rcN gives the following boot noise (and
>> the key does not work):
>>
>> ------------[ cut here ]------------
>> WARNING: at /home/elinwal/linux-stericsson/kernel/irq/irqdomain.c:137
>> irq_domain_legacy_revmap+0x20/0x48()
(...)
> I haven't tested this, but I think this patch should be pulled out
> of -next and pushed into the -rcs to fix the issue you see above.
> The real fix along with the revert to this patch also resides in
> -next and will be applied during the next merge window.

Dmitry, can you fix this?

v3.6-rc6 is regressing on us...

Yours,
Linus Walleij
