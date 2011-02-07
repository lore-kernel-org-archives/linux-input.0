From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Mon, 07 Feb 2011 17:04:20 +0000
Message-ID: <1297098262.29885.14.camel@novo.hadess.net>
References: <1296485689.7756.9.camel@novo.hadess.net>
	 <20110131212842.GB1603@polaris.bitmath.org>
	 <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	 <1296561717.15349.5.camel@novo.hadess.net>
	 <AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
	 <1296650569.2123.2.camel@novo.hadess.net>
	 <AANLkTinOK+=J64NRWZjit3S7hAdGVXxRE9HYkxTxrxON@mail.gmail.com>
	 <AANLkTi=MGNLfLHQpVEyJGtE-j-D0dj-RWXAihW1xMKDe@mail.gmail.com>
	 <1296922260.4223.4.camel@novo.hadess.net>
	 <AANLkTi=yTh4YSPSQBnPFPyen9vfyfYGiT6GJVEKwGHjh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:36829 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab1BGRGV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Feb 2011 12:06:21 -0500
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 805CA382AA
	for <linux-input@vger.kernel.org>; Mon,  7 Feb 2011 18:04:48 +0100 (CET)
In-Reply-To: <AANLkTi=yTh4YSPSQBnPFPyen9vfyfYGiT6GJVEKwGHjh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Mon, 2011-02-07 at 17:51 +0100, Benjamin Tissoires wrote:
> Hi Bastien,
> 
> On Sat, Feb 5, 2011 at 17:10, Bastien Nocera <hadess@hadess.net> wrote:
> > On Wed, 2011-02-02 at 14:20 +0100, Benjamin Tissoires wrote:
> >> With the patch this time.... ;)
> >>
> >> On Wed, Feb 2, 2011 at 14:18, Benjamin Tissoires
> >> <benjamin.tissoires@gmail.com> wrote:
> >> > On Wed, Feb 2, 2011 at 13:42, Bastien Nocera <hadess@hadess.net> wrote:
> >> >> On Tue, 2011-02-01 at 14:25 +0100, Benjamin Tissoires wrote:
> >> >> <snip>
> >> >>> First pass:
> >> >>> - please get the branch multitouch of jiri's tree (at
> >> >>> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/multitouch)
> >> >>> - then apply the attached patch (git am
> >> >>> 0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
> >> >>> - get your config from your current kernel (check that hid-multitouch
> >> >>> is enabled as a module)
> >> >>> - compile, install, reboot
> >> >>
> >> >> That's where I hit a problem. It seems that the kernel on which that
> >> >> branch is based has broken cgroups support (it panics on startup).
> >> >>
> >> >> Would your patch, or a patchset be available to apply to the close to
> >> >> Linus tree Fedora rawhide kernel?
> >> >
> >> > Hi Bastien,
> >> >
> >> > Sorry for that. Attached a new version that bumps a Linus' 2.6.38-rc2
> >> > or 2.6.38-rc3 to Jiri's tree and applies the patch above.
> >> >
> >> > If it's still not working, I'll send you the files directly ;)
> >
> > The instructions didn't quite work (the PCI ID seems to be in
> > upper-case, and the tail command wasn't producing any output). I used
> > good ol' 'cat' instead. Attached is what it produced.
> 
> oops... When you say "the PCI ID seems to be in upper-case", you means
> the path of the events file, or you had to modify the patch?

The sysfs path needed upper-case, yes. I did not change the patch.

> >
> > The cursor actually follows the touch, but it seems I need to press
> > quite hard to make it work.
> 
> Is this the same with a Windows system? I don't think we made any
> assumption on the pressure.

I have no idea. I booted Windows once on this machine, when I actually
got it. I can certainly check there though.

> > Touch with 2 fingers doesn't do anything
> > different from single finger.
> 
> This is quite normal: Linux is not ready for multitouch right now ;)
> Only the kernel is ready. People are working on x.org' XInput 2.1 to
> enable multitouch in X.org, and the toolkits are following this
> development.
> 
> If you want to give a try, you can download our mt-diagnostic software
> at:  http://lii-enac.fr/en/architecture/linux-input/mtdiag.html .

That's alright. I know of the efforts, I stupidly thought that this
would behave the same way as the MacBook touchpads (eg. give me access
to a right-click).

> >
> > Let me know if you want me to test anything else. I'll try not to take
> > as long to do the testing next time, but we were working on our first
> > GNOME 3 test day.
> 
> Well, the device does not sends much relevant informations: we have to
> rebuild some informations, so the final patch will be really close to
> the one I sent last week. Once I made it, I'll ask you to test it
> before submitting it for 2.6.38 (if it's still possible).

Sure thing. I'll look for it in my mail.

Still interested in me trying out Windows for that "need to press hard"
touch?

Cheers

