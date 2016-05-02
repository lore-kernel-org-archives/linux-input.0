From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to properly extend uinput API
Date: Mon, 2 May 2016 11:35:42 -0700
Message-ID: <20160502183542.GC37394@dtor-ws>
References: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32859 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbcEBSfq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2016 14:35:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id 206so82670654pfu.0
        for <linux-input@vger.kernel.org>; Mon, 02 May 2016 11:35:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Manuel,

On Sat, Apr 30, 2016 at 11:36:24AM +0200, Manuel Reimer wrote:
> Hello,
> 
> I'm currently trying to somehow get uinput connected with ff-memless.

I am not sure that exposing ff-memless to userspace is a good idea.
Right now what we have is a supporting library for several kernel
modules and there were considerations to change it to work differently.

I'd rather userspace took care of handling dumb devices if t decided to
handle device communication instead of leaving it to the kernel.

Thanks.

> 
> My first try (which is some kind of hack which prevents API changes
> and doesn't work at all) failed. Now my idea is to add some more
> simple (and probably working) API for this. All, I need in the
> "memless case", is some way to get two motor speeds sent to
> usermode, which doesn't require all this callback stuff.
> 
> There is a new API which, as far as I understand, is meant to be
> easier extendable:
> https://github.com/torvalds/linux/commit/052876f8e5
> 
> What I need is some way to pass an additional boolean to tell the
> kernel module that usermode wants to use ff-memless. Device setup is
> done with an struct "uinput_setup". As far as I know it isn't easily
> possible to extend this without breaking existing stuff.
> 
> It would be possible to write some hack which passes this
> information via magic-value through ff_effects_max but I think there
> has to be some nicer way.
> 
> So how to pass one more piece of information from usermode to kernel
> module while setup without breaking existing (probably
> closed-source) stuff? Keep a definition of the old struct version
> and decide which one to use based on size?
> 
> Thank you very much in advance for any help.
> 
> Manuel

-- 
Dmitry
