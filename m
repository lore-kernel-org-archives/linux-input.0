From: Leslie Viljoen <leslieviljoen@gmail.com>
Subject: Re: [PATCH] Driver for Bosto 14WA graphics tablet
Date: Tue, 6 Oct 2015 11:12:11 +1300
Message-ID: <CAGFQMzTRfwsz8AN2jfTE_7eBNVsAvHhkHy4X_W+RqpMW9_z10w@mail.gmail.com>
References: <CAGFQMzQsgMYDwZrq7B1_PNohd7wY6bd5zybB_URKTDJss7gNXQ@mail.gmail.com>
 <CAN+gG=F+uCdcrsMO7iowo+TJ_CkM5LD_c6q+Fv1H_e4_cVY14g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33163 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbbJEWMb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2015 18:12:31 -0400
Received: by iofh134 with SMTP id h134so202486960iof.0
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2015 15:12:31 -0700 (PDT)
In-Reply-To: <CAN+gG=F+uCdcrsMO7iowo+TJ_CkM5LD_c6q+Fv1H_e4_cVY14g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Oct 5, 2015 at 10:19 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> accept such a patch. I would encourage you to directly use the command
> "git send-email" to send patches.

Great, I didn't realise this existed.

> Ideally you do. This is mainly to receive patches from others when
> they are sending patches against your driver. This way, you can be
> sure not to break your current device. On a day to day basis, we do
> not update it as often as we should, and this is a little bit of a
> shame :)

Ok, I will update it.

> drivers/hid/hid-primax.c is a driver with just a raw_event processing,
> and you might want to use it as a basis.

Thanks for the feedback, I'll take a look at that! So far I'd just been
extrapolating from the Hanwang driver and was not aware of other
possibilities!
