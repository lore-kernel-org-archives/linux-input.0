From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Wed, 3 May 2017 11:53:22 +0200
Message-ID: <CAJKOXPenTK502WyOd-6LT1z3o3NohKT59wt0aG-Z4x9jkEje+A@mail.gmail.com>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
 <20170424094231.435f82de@endymion> <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
 <20170425115500.6d5c8bee@endymion> <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
 <20170425172809.GC30843@dtor-ws> <20170503114223.1c3e08f7@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbdECJx2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 3 May 2017 05:53:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5B47B2022A
        for <linux-input@vger.kernel.org>; Wed,  3 May 2017 09:53:26 +0000 (UTC)
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com [209.85.223.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311482026C
        for <linux-input@vger.kernel.org>; Wed,  3 May 2017 09:53:24 +0000 (UTC)
Received: by mail-io0-f169.google.com with SMTP id r16so181683310ioi.2
        for <linux-input@vger.kernel.org>; Wed, 03 May 2017 02:53:24 -0700 (PDT)
In-Reply-To: <20170503114223.1c3e08f7@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>

On Wed, May 3, 2017 at 11:42 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> I am all for adding dependencies for drivers that are parts of
>> particular SoCs (you probably not going to have Broardcom IPROC
>> touchscreen on your x86 device), but external to SoC peripherals is a
>> different story.
>
> I understand that there is no direct relation between this TM2 touchkey
> driver and Exynos as a platform.
>
> My reasoning is as follows: given that at this point this driver is
> only useful on the Samsung TM2 board, it should only be presented to
> users configuring a kernel for that board. Then the question becomes:
> what other kernel option will definitely be enabled on any kernel
> running on that board? As the TM2 is based on an Exynos5433 SoC,
> ARCH_EXYNOS will have to be enabled, so it seems a convenient way to
> limit the visibility of KEYBOARD_TM2_TOUCHKEY.
>
> There are certainly other options that will also be always enabled for
> a TM2 board kernel, but ARCH_EXYNOS seems to be a good choice because
> it is both generic enough that it doesn't need to be changed if a
> variation of the TM2 board is released using a slightly different SoC,
> and specific enough that we will skip the question for most users.
>
> The alternative would be to add another option SAMSUNG_TM2 ("Support for
> the Samsung TM2 board"), just to let KEYBOARD_TM2_TOUCHKEY depend on it,
> but that's really only moving the problem, as there is no point in
> asking people about SAMSUNG_TM2 if they are building a kernel that can't
> support it anyway. And while I agree it would be somewhat cleaner to
> have KEYBOARD_TM2_TOUCHKEY which depends on SAMSUNG_TM2 and SAMSUNG_TM2
> which depends on ARCH_EXYNOS, it also seems overly complex to me for no
> benefit.
>
> Therefore I still believe that making KEYBOARD_TM2_TOUCHKEY depend on
> ARCH_EXYNOS || COMPILE_TEST makes sense from a practical perspective.

As I mentioned at beginning, I limiting unusable options looks worth
adding to the kernel as a new keyword. However dependency is not for
that purpose because this is not a hardware/software dependency. You
need to add something similar to "imply" keyword, but working not for
select statements but for dependencies. I think such new keyword would
be useful not only for Suse kernels but for many others as well.

But if you do not wish to do it right, then please do not go with this
workaround making a hard (static) dependency between some driver and
some ARM architecture.

On the other hand, maybe this particular driver problem for you can be
solved by removing i2c device binding and adding dependency on OF.
Assuming of course, you do not choose OF for your kernels.

Best regards,
Krzysztof
