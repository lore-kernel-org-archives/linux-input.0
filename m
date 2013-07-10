From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Wed, 10 Jul 2013 09:52:47 -0700
Message-ID: <20130710165247.GA22992@core.coreip.homeip.net>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
 <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org>
 <20130627162820.GA12070@core.coreip.homeip.net>
 <51CC7CD5.5090508@linaro.org>
 <20130627182500.GB12961@core.coreip.homeip.net>
 <51CC8786.1070200@linaro.org>
 <20130628060945.GA17523@core.coreip.homeip.net>
 <51CD8D4A.10207@linaro.org>
 <20130710151457.D0B863E1168@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:55979 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab3GJQwx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 12:52:53 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so6921206pbc.9
        for <linux-input@vger.kernel.org>; Wed, 10 Jul 2013 09:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130710151457.D0B863E1168@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wrote:
> On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> > On 13-06-28 12:09 AM, Dmitry Torokhov wrote:
> > >>>> I do not agree.  We want the binding to be generic and not tied
> > >>>> specifically to the keyreset functionality.  As such 'input-keyset' or
> > >>>> 'input-keychord' are more appropriate.
> > >>>
> > >>> The binding is defined specifically for sysrq and specifically to
> > >>> perform reset action.
> > >>
> > >> Yes for now but as the examples in the binding show, it is easy to
> > >> envision how other drivers could use it.
> > > 
> > > I think you over-complicate things here. Unlike matrix-keypad binding,
> > > where you have a common parsing code, here we have an individual driver.
> > > I really do not see anyone else using such sequences or chords as such
> > > processing should be done in userspace. Sysrq is quite an exception.
> > 
> > To be honest I don't have a very strong opinion on the binding.  I made
> > it as generic as possible on the guidance of the DT people.  Let's see
> > what they think of it.
> 
> Hi Mathieu,
> 
> As per our conversation just now at Connect, the binding should probably
> look like this:
> 
> Sysrq keyset binding:
> 
> The /chosen node can contain a linux,input-keyset-sysrq child node to
> define a set of keys that will generate a sysrq when pressed together.

Hmm, we would have only one such node, /sysrq, or /linux,sysrq,
whatever. The sysrq setting is system-wide and applicable to all
devices. Given that it is used only on mobile, where there not that
many input devices (a few keys and touchscreen) I do not believe we
should consider adding per-device settings.

> 
> Required properties:
> keyset: array of keycodes

Please, let's call it 'key-reset-seq', because it is exactly the reset
sequence. There won't be any additional sequences or chords as those
should be handled in userspace, sysrq is a special case here.

> timeout-ms: duration keys must be pressed together in microseconds
> before generating a sysrq
> 

Thanks.

-- 
Dmitry
