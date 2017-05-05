From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: The way of touch finger and pen stylus report
Date: Fri, 5 May 2017 09:34:01 +0200
Message-ID: <CAN+gG=HjAO=uAegv8BFPEOe2O4rbTpC6-=idwgfq_9pg3n5j9w@mail.gmail.com>
References: <002301d2c571$8cadc360$a6094a20$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34115 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdEEHeD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 03:34:03 -0400
Received: by mail-wr0-f182.google.com with SMTP id l9so18955533wre.1
        for <linux-input@vger.kernel.org>; Fri, 05 May 2017 00:34:03 -0700 (PDT)
In-Reply-To: <002301d2c571$8cadc360$a6094a20$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, May 5, 2017 at 9:31 AM, =E5=8A=89=E5=98=89=E9=A7=BF <scott.liu@emc.=
com.tw> wrote:
> Hi Benjamin,
>         My device is hidi2c and finger / pen has described in descriptor.
>         So does hid-multitouch module support it?

hid-multitouch should handle it properly as long as the device follows
MS' specification.

Cheers,
Benjamin

>
> Thanks.
>
> BR,
> Scott
>
>
