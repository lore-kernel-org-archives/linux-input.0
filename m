From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Wed, 10 Jul 2013 15:55:28 -0700
Message-ID: <3581403.5tvsHCRkpG@dtor-d630.eng.vmware.com>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org> <3572203.AkEVm8LFzu@dtor-d630.eng.vmware.com> <CANLsYkw==yAEcwD9RAPCCHB0Y45Bo2MnfLSVP5s-g6kpAu9k4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57716 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab3GJWzc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 18:55:32 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so6854470pde.37
        for <linux-input@vger.kernel.org>; Wed, 10 Jul 2013 15:55:32 -0700 (PDT)
In-Reply-To: <CANLsYkw==yAEcwD9RAPCCHB0Y45Bo2MnfLSVP5s-g6kpAu9k4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, John Stultz <john.stultz@linaro.org>, kernel-team@android.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wednesday, July 10, 2013 04:29:00 PM Mathieu Poirier wrote:
> On 10 July 2013 16:20, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Wednesday, July 10, 2013 10:50:26 PM Grant Likely wrote:
> > > On Wed, Jul 10, 2013 at 5:52 PM, Dmitry Torokhov
> > > 
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wrote:
> > > >> On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier
> > 
> > <mathieu.poirier@linaro.org> wrote:
> > > >> > On 13-06-28 12:09 AM, Dmitry Torokhov wrote:
> > > >> > >>>> I do not agree.  We want the binding to be generic and not
> > > >> > >>>> tied
> > > >> > >>>> specifically to the keyreset functionality.  As such
> > > >> > >>>> 'input-keyset' or
> > > >> > >>>> 'input-keychord' are more appropriate.
> > > >> > >>> 
> > > >> > >>> The binding is defined specifically for sysrq and specifically
> > 
> > to
> > 
> > > >> > >>> perform reset action.
> > > >> > >> 
> > > >> > >> Yes for now but as the examples in the binding show, it is easy
> > 
> > to
> > 
> > > >> > >> envision how other drivers could use it.
> > > >> > > 
> > > >> > > I think you over-complicate things here. Unlike matrix-keypad
> > > >> > > binding,
> > > >> > > where you have a common parsing code, here we have an individual
> > > >> > > driver.
> > > >> > > I really do not see anyone else using such sequences or chords as
> > > >> > > such
> > > >> > > processing should be done in userspace. Sysrq is quite an
> > 
> > exception.
> > 
> > > >> > To be honest I don't have a very strong opinion on the binding.  I
> > 
> > made
> > 
> > > >> > it as generic as possible on the guidance of the DT people.  Let's
> > 
> > see
> > 
> > > >> > what they think of it.
> > > >> 
> > > >> Hi Mathieu,
> > > >> 
> > > >> As per our conversation just now at Connect, the binding should
> > 
> > probably
> > 
> > > >> look like this:
> > > >> 
> > > >> Sysrq keyset binding:
> > > >> 
> > > >> The /chosen node can contain a linux,input-keyset-sysrq child node to
> > > >> define a set of keys that will generate a sysrq when pressed
> > > >> together.
> > > > 
> > > > Hmm, we would have only one such node, /sysrq, or /linux,sysrq,
> > > > whatever. The sysrq setting is system-wide and applicable to all
> > > > devices. Given that it is used only on mobile, where there not that
> > > > many input devices (a few keys and touchscreen) I do not believe we
> > > > should consider adding per-device settings.
> > > 
> > > It's in /chosen, that isn't per-device.
> > > 
> > > >> Required properties:
> > > >> keyset: array of keycodes
> > > > 
> > > > Please, let's call it 'key-reset-seq', because it is exactly the reset
> > > > sequence. There won't be any additional sequences or chords as those
> > > > should be handled in userspace, sysrq is a special case here.
> > > 
> > > This is absolutely a linux-specific binding. It encodes the Linux
> > > keycodes, and generates a linux meaning. I'm usually all about
> > > carrying the OS-independent banner when defining DT bindings, but in
> > > this case the linux prefix and sysrq reference is completely
> > > appropriate.
> > 
> > OK, I have no idea what "/chosen" actually means. What I am trying to say
> > that there should be either "sysrq" or "linux,sysrq" node and that is what
> > sysrq driver will be looking for.
> 
> Chosen pertains to system wide parameters that aren't related to hw
> specific devices.  Correct, the driver will look exactly for
> "linux,sysrq-reset-seq" in the "chosen" node and nowhere else.

OK, it looks like we are talking about the same thing. I seem to have
mis-parsed the original proposal.

Thanks,
Dmitry

