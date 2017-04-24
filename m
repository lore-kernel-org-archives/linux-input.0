From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Mon, 24 Apr 2017 11:58:09 +0200
Message-ID: <CAJKOXPdOAkpDNrgk_3Lk+GvTQm8=_e45ydTXUkVFardacJ3PEQ@mail.gmail.com>
References: <20170424094231.435f82de@endymion> <CAJKOXPc6EW-yF923_TfK56ukutF6HtCs=odbtCBVTFbHq8WL+g@mail.gmail.com>
 <20170424114841.130cad35@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165550AbdDXJ6M (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 05:58:12 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E112120160
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 09:58:10 +0000 (UTC)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com [209.85.214.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F077320145
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 09:58:09 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id g66so52937983ite.1
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 02:58:09 -0700 (PDT)
In-Reply-To: <20170424114841.130cad35@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Apr 24, 2017 at 11:48 AM, Jean Delvare <jdelvare@suse.de> wrote:
> On Mon, 24 Apr 2017 10:00:32 +0200, Krzysztof Kozlowski wrote:
> > On Mon, Apr 24, 2017 at 9:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > > The tm2-touchkey driver is only useful on specific platforms. Add the
> > > missing hardware dependency so that the driver is not proposed on
> > > systems where the device does not exist.
> >
> > Although the device exists in only two upstreamed Exynos boards but
> > there is no hardware dependency on Exynos. The hardware does not
> > depend on Exynos.
>
> I understand that, and this is the reason why there was no dependency
> expressed so far. But this is irrelevant to the problem I am trying to
> solve, which is that people configuring a kernel for platforms where
> this device is known to NOT exist shouldn't be bothered with a question
> about its driver. This is what I meant with "hardware dependency" but
> you can call it "hardware focus" or "intended hardware target" if you
> prefer.

You need a depends-like version of "imply" keyword. I think it is
worth adding it to solve such problems and help in configuring the
system. However I am not convinced that "depends" should be used in
the meaning of "intended use".

Best regards,
Krzysztof
