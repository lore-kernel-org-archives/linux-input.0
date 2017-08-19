From: Adam Goode <adam@spicenitz.org>
Subject: Re: successful intertouch support: PNP: LEN2014 PNP0f13
Date: Fri, 18 Aug 2017 21:16:29 -0400
Message-ID: <CACuduqpaphKn-sxSgutHaRt7AKZBUYZzvV3oTj-F5G1wjdhatA@mail.gmail.com>
References: <CACuduqo7g9fJbjR3d0DStKMaRCc8H5W39yjqUDXWV+Nb6FiXSA@mail.gmail.com>
 <CACuduqphCpX4P3A97Uve2-Dt7hrREUNKQ7jibxnoHWacF=4DGA@mail.gmail.com> <20170819.094933.525138418732323242.teika@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52995 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750988AbdHSBRl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Aug 2017 21:17:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BD2C521304
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 21:16:50 -0400 (EDT)
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com [209.85.218.54])
        by mail.messagingengine.com (Postfix) with ESMTPA id 835937E86A
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 21:16:50 -0400 (EDT)
Received: by mail-oi0-f54.google.com with SMTP id f11so112115828oic.0
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 18:16:50 -0700 (PDT)
In-Reply-To: <20170819.094933.525138418732323242.teika@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Teika Kazura <teika@gmx.com>
Cc: linux-input@vger.kernel.org

On Fri, Aug 18, 2017 at 8:49 PM, Teika Kazura <teika@gmx.com> wrote:
>
> From: Adam Goode <adam@spicenitz.org>
> Subject: Re: successful intertouch support: PNP: LEN2014 PNP0f13
> Date: Fri, 18 Aug 2017 08:59:19 -0400
>
> > This failed to resume from sleep. Neither the trackpad nor the
> > touchpoint work, and I cannot suspend again.
>
> Maybe this recent thread is relevant? (From the archived linux-input@vger.kernel.org)
> http://www.spinics.net/lists/linux-input/msg52384.html
>
> (I'm not a kernel developer. I've just sent a report similar to yours.)
>

Oh, thank you for that link! It looks like a generic patch is indeed needed.

I do not see any such patch in any git tree, so I guess it still needs
to be written/accepted.
I looked at https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/


Thanks,

Adam

>
> Teika (Teika kazura)
