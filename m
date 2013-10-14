From: Tom Gundersen <teg@jklm.no>
Subject: Re: WPC8769L (WEC1020) support in winbond-cir?
Date: Mon, 14 Oct 2013 16:42:07 +0200
Message-ID: <CAG-2HqXOhjVWuBE=UHdP9H69KZrsz=rvtVoDdTcqg9ahY0zuLQ@mail.gmail.com>
References: <CAG-2HqX-TO7h8zJ6F01r2LfRVjQtb0pK_1wKGsYVKzB0zC7TQA@mail.gmail.com>
 <20131014110748.366ea45e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:50026 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab3JNOm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Oct 2013 10:42:29 -0400
Received: by mail-bk0-f50.google.com with SMTP id mz11so2624520bkb.23
        for <linux-input@vger.kernel.org>; Mon, 14 Oct 2013 07:42:27 -0700 (PDT)
In-Reply-To: <20131014110748.366ea45e@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Juan J. Garcia de Soria" <skandalfo@gmail.com>, =?UTF-8?Q?David_H=C3=A4rdeman?= <david@hardeman.nu>, Sean Young <sean@mess.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LMML <linux-media@vger.kernel.org>

On Mon, Oct 14, 2013 at 4:07 PM, Mauro Carvalho Chehab
<m.chehab@samsung.com> wrote:
> Hi Tom,
>
> Em Mon, 14 Oct 2013 15:16:20 +0200
> Tom Gundersen <teg@jklm.no> escreveu:
>
>> Hi David and Juan,
>>
>> I'm going through the various out-of-tree LIRC drivers to see if we
>> can stop shipping them in Arch Linux [0]. So far it appears we can
>> drop all except for lirc_wpc8769l [1] (PnP id WEC1020).
>
> Please copy the Linux Media ML to all Remote Controller drivers. There's
> where we're discussing those drivers. No need to c/c linux-input.
>
> Yeah, both lirc_atiusb and lirc_i2c were now obsoleted by upstream
> non-staging drivers. I suggest to just drop it from Arch Linux.

Thanks for the info, we'll drop those drivers.

Cheers,

Tom
