From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Mon, 22 Oct 2012 08:54:46 -0700
Message-ID: <20121022155446.GB13791@core.coreip.homeip.net>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
 <21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
 <CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:36107 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2JVPyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 11:54:51 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1442366dak.19
        for <linux-input@vger.kernel.org>; Mon, 22 Oct 2012 08:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-input@vger.kernel.org

On Mon, Oct 22, 2012 at 09:42:17AM +0800, Ming Lei wrote:
> Hi Dmitry,
> 
> On Thu, Oct 18, 2012 at 1:30 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > I see it is broken in X, but it works for me if I am using the console.
> > Does it work for you as well if you switch into the console? If so then
> > you need to file a bug against X.
> 
> Thanks for your reply.
> 
> Unluckily, it becomes worse if I switch to console and capslock leds
> in both keyborads are not changed but the function is OK.
> 
> So you mean the led is controlled by user-space totally? and Kernel
> doesn't handle the case?

Keyboard LEDs are controlled by the kernel unless console is in the raw
mode (X), in which case it is left to userspace. I see it on my box that
sync between keyboards is broken while I am in X (so it is X problem)
and works when I am in text console (so I do not see the kernel
problem).

Since it does not work for you in text console either your setup must be
different than mine. If you switch to a text console and do

	sudo lsof /dev/input/event*

what do you see?

Thanks.

-- 
Dmitry
