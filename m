From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hidraw: fix nonblock read return EAGAIN after device
 removed
Date: Mon, 26 Nov 2012 14:18:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211261417470.12570@pobox.suse.cz>
References: <CAHLfQU=Hrufny=652k2mM7OcjxnRMH-kgj510FZrrKtiKNxdgw@mail.gmail.com> <CAHLfQUnhEQBC+yzB3jFnJbB7jMvuVjr1M62kzxWzMN2v0i=VzA@mail.gmail.com> <20121126081512.GD21091@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121126081512.GD21091@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "founder.fang" <founder.fang@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 26 Nov 2012, Dmitry Torokhov wrote:

> > Hi Linux-Input, Jiri, Dmitry,
> > this patch is related to nonblock read on hidraw device.
> > when nonblock read the condition check (file->f_flags & O_NONBLOCK)
> > always be true,
> > signal_pending and device exist checking never get a chance to run, so
> > the user mode code always
> > get EAGAIN even if device removed. move nonblock mode checking to the
> > last can fix this problem.
> > 
> > Signed-off-by: Founder Fang <founder.fang@gmail.com>
> > 
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Makes sense to me. However it looks like your mailer line-wrapped the
> patch, please resend so Jiri can apply it.

For some reason, the patch has been sent to me twice, once it has been 
fine and the second time it has been line wrapped.

I have now applied the non-broken version. Thanks,

-- 
Jiri Kosina
SUSE Labs
