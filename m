From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Tue, 23 Oct 2012 10:48:34 -0700
Message-ID: <20121023174834.GB649@core.coreip.homeip.net>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
 <21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
 <CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
 <20121022155446.GB13791@core.coreip.homeip.net>
 <CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36830 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab2JWRsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Oct 2012 13:48:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2924568pad.19
        for <linux-input@vger.kernel.org>; Tue, 23 Oct 2012 10:48:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 23, 2012 at 09:20:17AM +0800, Ming Lei wrote:
> On Mon, Oct 22, 2012 at 11:54 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Keyboard LEDs are controlled by the kernel unless console is in the raw
> > mode (X), in which case it is left to userspace. I see it on my box that
> > sync between keyboards is broken while I am in X (so it is X problem)
> > and works when I am in text console (so I do not see the kernel
> > problem).
> >
> > Since it does not work for you in text console either your setup must be
> > different than mine. If you switch to a text console and do
> >
> >         sudo lsof /dev/input/event*
> >
> > what do you see?
> 
> - lsof output from text console
> 
> lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system /home/tom/.gvfs
>       Output information may be incomplete.
> COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> upowerd 2956 root   13r   CHR  13,64      0t0 7050 /dev/input/event0

Hmm, this looks correct. Do you have similar issues on any other boxes
or only your laptop? Does the LED state propagate between 2 USB
keyboards if you plug in both of them? What does /proc/bus/input/devices
show?

Thanks.

-- 
Dmitry
