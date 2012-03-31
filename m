From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH RESEND 2/2] Input: uinput: Avoid returning 0 on read()
Date: Sat, 31 Mar 2012 10:39:49 +0200
Message-ID: <CANq1E4TJ3DPKjx7WBFFJUzLL-pZESYtKL6UadvdYBjE+vm_2uw@mail.gmail.com>
References: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
	<20120331060033.GA12307@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38794 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2CaIju (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 04:39:50 -0400
Received: by wejx9 with SMTP id x9so784237wej.19
        for <linux-input@vger.kernel.org>; Sat, 31 Mar 2012 01:39:49 -0700 (PDT)
In-Reply-To: <20120331060033.GA12307@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

Hi Dmitry

On Sat, Mar 31, 2012 at 8:00 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
<snip>
> I agree that we should return -EINVAL when buffer is too small. I
> however do not like the whole "try_again" business; I think it is
> perfectly fine to return 0 for blocking reads, we just want to return
> -EAGAIN for nonblocking.

The read() manpage says that return-code 0 means the fd got closed.
Does the VFS layer forward the return-code untouched to user-space or
why do you think returning 0 is fine? At least my uinput user-space
apps handle read()==0 as failure.

> I changed around your patches a bit and will post them shortly.

Apart from the ret==0 issue I have nothing to object. If you want to
apply them the way they're now, I am ok with it, too. Thanks for
cleaning them up.

> Aristeu, since the patches changed somewhat I dropped your Acked-by so
> please Ack the patches you are comfortable with again.
>
> Thanks.
>
> --
> Dmitry

Thanks
David
