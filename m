From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Tue, 23 Oct 2012 22:24:20 -0700
Message-ID: <20121024052420.GB13826@core.coreip.homeip.net>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
 <21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
 <CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
 <20121022155446.GB13791@core.coreip.homeip.net>
 <CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
 <20121023174834.GB649@core.coreip.homeip.net>
 <CACVXFVNpYrET-2GoLsKEmds2Ua0QnCNwN-q+31hewNDnmdpN9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:56545 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab2JXFYY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 01:24:24 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so84415dak.19
        for <linux-input@vger.kernel.org>; Tue, 23 Oct 2012 22:24:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVNpYrET-2GoLsKEmds2Ua0QnCNwN-q+31hewNDnmdpN9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 24, 2012 at 08:39:51AM +0800, Ming Lei wrote:
> On Wed, Oct 24, 2012 at 1:48 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hmm, this looks correct. Do you have similar issues on any other boxes
> > or only your laptop? Does the LED state propagate between 2 USB
> 
> I only have one laptop at hand, :-(
> 
> > keyboards if you plug in both of them? What does /proc/bus/input/devices
> 
> I only have one usb keyboard too, :-(
> 
> The LED state becomes off once I switched to console via pressing 'ctrl+alt+F1',
> and it will keep off even though CAPSLOCK is pressed on either usb keyboard
> or ps/2 keyboard.
> 
> The above can be observed on 3.6 kernel and several precious kernel.
> (distribution is Ubuntu 12.04)

Do you have thinkpads platform driver loaded? What happens if you boot
with it blacklisted?

Thanks.

-- 
Dmitry
