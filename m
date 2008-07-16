From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [0/2] Jack reporting
Date: Wed, 16 Jul 2008 12:36:06 -0400
Message-ID: <20080716112939.ZZRA012@mailhub.coreip.homeip.net>
References: <20080703095026.GA652@sirena.org.uk> <20080714151058.GF25448@sirena.org.uk> <s5hlk02148k.wl%tiwai@suse.de> <20080716125053.GA17134@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:64453 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYGPQgJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jul 2008 12:36:09 -0400
Received: by wx-out-0506.google.com with SMTP id h29so3384875wxd.4
        for <linux-input@vger.kernel.org>; Wed, 16 Jul 2008 09:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080716125053.GA17134@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Wed, Jul 16, 2008 at 01:50:53PM +0100, Mark Brown wrote:
> On Wed, Jul 16, 2008 at 01:02:35PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > Takashi, do you have any comments on these patches?
> 
> > I have no strong opinion about this.  Your implementation looks small
> > enough.  But, if Dmitry finds the input layer not suitable for such a
> > purpose, this isn't a good way to go.
> 
> Unfortunately Dimitry hasn't been responding to any of the e-mails on
> this subject since his initial one.  :/
> 

Completely my fault, I am verry sorry.

> > I think the question is how general and how extensible these features
> > should be.  If it's just a jack reporting, there are bunch of other
> 
> To reiterate points I've previously made:
> 
> As well as detecting the presence of a connected device typical jack
> detection implementations also support the implementation of at least
> one button which would require an input device for at least some jacks
> even if something else were done.  This is consistent with existing
> usage of the input layer - it's similar to multimedia keys which are
> normally reported via the input layer.  Things like sleep and power
> buttons are implemented as individual input devices.
> 

It really depends on what you can do with this button. If it is just a
simple circuit breaker then it is not really an input device. However
is you can remap it for different purposes or map a regular key on a
keybaord to perform this function then I will agree with you. For example
sleep and power buttons can be anywhere. They can be implemented as
ACPI button but there also a bunch of keyboards that have a sleep
button on them. Or, like you said, multimedia keys - they not always
control hardware directly, often you have an option to remap and
re-use them.

> We do also already have existing in-kernel users of the input API to
> report jack status (usually done via GPIOs outside of ALSA).  From that
> point of view this ALSA helper is simply implementing the existing user
> space interface for reporting jacks.  I feel that if we want to do
> something different we should work out how to transition these existing
> users to it too.  We can always add the existing code while working out
> what that transition plan might be.

Yes, I agree, we would need to transit the existing users to the new
scheme.

-- 
Dmitry
