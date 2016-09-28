From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH 2/2] hid: input: add HID_QUIRK_REUSE_AXES and fix dragonrise
Date: Wed, 28 Sep 2016 14:59:11 +0300
Message-ID: <87y42c5j74.fsf@adirat.com>
References: <20160926025839.2790-1-adi@adirat.com> <20160926025839.2790-2-adi@adirat.com> <20160926092903.GC19261@mail.corp.redhat.com> <f3f844b7-777e-41ce-4661-bcf8735763c6@gmail.com> <CABnEwuryj9rbeETuO+agekioq8wFd_6H0cZPCs+=Ft8c-=5j9g@mail.gmail.com> <874m5173ex.fsf@ni.com> <CABnEwuqXSje=Y0a49R4OfMxPvL4nAwxQqrhA+i-cce020wD90A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34153 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbcI1MAv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 08:00:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id l132so5575856wmf.1
        for <linux-input@vger.kernel.org>; Wed, 28 Sep 2016 05:00:50 -0700 (PDT)
In-Reply-To: <CABnEwuqXSje=Y0a49R4OfMxPvL4nAwxQqrhA+i-cce020wD90A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladislav Naumov <vnaum@vnaum.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 28 Sep 2016, Vladislav Naumov <vnaum@vnaum.com> wrote:
> On Tue, Sep 27, 2016 at 10:44 PM, Ioan-Adrian Ratiu <adi@adirat.com> wrote:
>> Can you please wait a little until I post v2 later today and test v2
>> directly? Because the change in it's current form has no effect on
>> 0079:0011 (the current quirk is enabled only for 0006).
>
> Sure thing!
> Just drop me a line when it's ready.

Hi

I posted v2 last night but instead of adding you to CC now I see I've
added Nikolai by mistake.

You can use this branch [1] from github if you want to build the patches
applied directly to linus' master (they are HEAD and HEAD~1 commits).

[1] https://github.com/10ne1/linux/commits/dev/aratiu/fix-dragonrise-gamepad

Cheers,
Adrian
