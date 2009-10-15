From: Daniel FAIVRE <webmaster@geomaticien.com>
Subject: Re: [opensuse-kernel] Re: Fwd: OBS HEAD kernel-desktop
Date: Thu, 15 Oct 2009 05:47:29 +0200
Message-ID: <200910150547.30061.webmaster@geomaticien.com>
References: <4AD5DEF5.9020401@suse.com> <20091014205745.GC5623@suse.de> <alpine.LSU.2.00.0910142342190.8582@wotan.suse.de>
Reply-To: webmaster@geomaticien.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:32953 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303AbZJODre (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 23:47:34 -0400
In-Reply-To: <alpine.LSU.2.00.0910142342190.8582@wotan.suse.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

Jiri :  CONFIG_HID_*=m is THE solution !!! Please commit it as soon as 
possible !!! ;-)

> On Wed, 14 Oct 2009, Greg KH wrote:
> > > There's a problem with builtin hid-ntrig in kernel-desktop : the
> > > hid-ntrig is
> > > NOT working (stylus button do NOT work) : it would be a great idea NOT
> > > to embed hid-ntrig in the kernel, and to include it only as a module,
> > > until developments evolutes enough to get a correct basic support.
> > >
> > > Actually, there's no way to get it work except recompiling the whole
> > > kernel without builtin hid-ntrig ...
> >
> > So just pick one hid device as a module?  Sure, I don't object to doing
> > that if it fixes problems for people.
> >
> > What specific config option should be changed?
>
> Apparently we are having CONFIG_HID_*=y for -desktop flavour. I think it
> might be good idea to change it back to =m, to be in sync with other
> flavours, vanilla defaults, etc.

Yes !!! That's the best idea : as a workaround, i recompiled a kernel with 
 CONFIG_HID_*=m

>
> Daniel, could you please report the problems you are having with hid-ntrig
> upstream? That would mean sending the description of the misbehavior of
> the driver to
>
> 	Rafi Rubin <rafi@seas.upenn.edu>
> 	Stephane Chatty <chatty@enac.fr>
> 	Jiri Kosina <jkosina@suse.cz>
> 	linux-input@vger.kernel.org
>
> Thanks,

n-trig is known NOT to work with opensuse 11.1, due to missing support in 
2.6.27 kernel.
A workaround could be installing a new kernel from HEAD. Unfortunately, with 
2.6.31 kernel from openSuSE HEAD repository, the stylus button do NOT work.
(wacdump report stylus button click as a left mouseclick)
Some peoples suggest patches for kernels > 2.6.30
Rafi suggested a patch here : http://ofb.net/~rafi/latitude_xt.html
Will it fix the stylus button issue ? Nevertheless, a python script available 
on several Ubuntu forums show that the button is working properly, BUT remain 
unavailable for linuxwacom (which need to be patched too just to enable 1b96 
vendor and 0x01 and 0x02 devices). 

I will test patched hid-ntrig.ko tomorrow, with a recompiled kernel, and 
different patches.

Nevertheless, I'm interested to contribute both for solving these issue and 
for improving opensuse/linux tabletPC computing.

Under linux, we still lack some cool features available on windows, and that 
is a serious disability to promote our favourite OS on tabletPCs :
- right-click on delayed touch / stylus pressure, with visual feedback (may be 
possible with improved linuxwacom / xorg configuration, except for visual 
feedback ? I saw some xorg.conf with things like "longtouch" ... for evtouch 
driver ;-/ )
- multitouch (many things to do, from low-level drivers to KDE integration !)

And more difficult:
- handwriting recognition (cellwriter is far under the windows tool)
- speech recognition (embedded in windows since Vista !!!). Some engines 
exists, but not much anything else ...

One last thing, about hp-tx2 : does somebody get the three buttons under the 
fingerprint reader works and mapped to relevant actions under kde ???

Bests regards,
-- 
Daniel FAIVRE

