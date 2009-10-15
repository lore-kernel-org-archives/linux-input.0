From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [opensuse-kernel] Re: Fwd: OBS HEAD kernel-desktop
Date: Thu, 15 Oct 2009 02:19:36 -0400
Message-ID: <4AD6BEF8.6040308@seas.upenn.edu>
References: <4AD5DEF5.9020401@suse.com> <20091014205745.GC5623@suse.de> <alpine.LSU.2.00.0910142342190.8582@wotan.suse.de> <200910150547.30061.webmaster@geomaticien.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:35056 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbZJOGeI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2009 02:34:08 -0400
In-Reply-To: <200910150547.30061.webmaster@geomaticien.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: webmaster@geomaticien.com
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel FAIVRE wrote:
> Jiri :  CONFIG_HID_*=m is THE solution !!! Please commit it as soon as 
> possible !!! ;-)
> 
>> On Wed, 14 Oct 2009, Greg KH wrote:
>>>> There's a problem with builtin hid-ntrig in kernel-desktop : the
>>>> hid-ntrig is
>>>> NOT working (stylus button do NOT work) : it would be a great idea NOT
>>>> to embed hid-ntrig in the kernel, and to include it only as a module,
>>>> until developments evolutes enough to get a correct basic support.
>>>>
>>>> Actually, there's no way to get it work except recompiling the whole
>>>> kernel without builtin hid-ntrig ...
>>> So just pick one hid device as a module?  Sure, I don't object to doing
>>> that if it fixes problems for people.
>>>
>>> What specific config option should be changed?
>> Apparently we are having CONFIG_HID_*=y for -desktop flavour. I think it
>> might be good idea to change it back to =m, to be in sync with other
>> flavours, vanilla defaults, etc.
> 
> Yes !!! That's the best idea : as a workaround, i recompiled a kernel with 
>  CONFIG_HID_*=m
> 
>> Daniel, could you please report the problems you are having with hid-ntrig
>> upstream? That would mean sending the description of the misbehavior of
>> the driver to
>>
>> 	Rafi Rubin <rafi@seas.upenn.edu>
>> 	Stephane Chatty <chatty@enac.fr>
>> 	Jiri Kosina <jkosina@suse.cz>
>> 	linux-input@vger.kernel.org
>>
>> Thanks,
> 
> n-trig is known NOT to work with opensuse 11.1, due to missing support in 
> 2.6.27 kernel.
> A workaround could be installing a new kernel from HEAD. Unfortunately, with 
> 2.6.31 kernel from openSuSE HEAD repository, the stylus button do NOT work.
> (wacdump report stylus button click as a left mouseclick)
> Some peoples suggest patches for kernels > 2.6.30
> Rafi suggested a patch here : http://ofb.net/~rafi/latitude_xt.html
> Will it fix the stylus button issue ? Nevertheless, a python script available 
> on several Ubuntu forums show that the button is working properly, BUT remain 
> unavailable for linuxwacom (which need to be patched too just to enable 1b96 
> vendor and 0x01 and 0x02 devices). 

The break in the stylus buttons was the result of minor mistake added with the conversion to a multitouch driver.  Jiri already
passed my most recent patches up to Linus, and I can confirm the fix is in HEAD.  I think its been in there since before 2.6.32-rc1.

My apologies for missing the bug with in the previous version, I really should have caught it immediately.  The error really was
just masking out the stylus button events during initialization, so quite easy to fix.

My website has no further patches for the kernel driver for the tablet at this time.

I did send in the patch to the linuxwacom project, but as of yet it has not been accepted.  The patch adds two things:
the resolution and adds the ntrig id to a predicate which otherwise rejects all non-wacom devices.  The resolution is not strictly
necessary since the run-time configuration provides sufficient options.  As for the manufacturer limiting, that was added only after
the initial ntrig patches to the kernel.  Given the circumstances it seems likely that the specific blocking is intentional.  While
I understand why they might prefer to limit the support of that driver, it works very well with my digitizer and I expect to
continue using it and supporting the id patch.  Thank you Ping for such a nice driver, it has been quite helpful.


Multitouch on the ntrig is another question.  It might just be a matter of initialization with the current firmware.  Stephane has
used multitouch with older firmwares (without extra init), but with those versions he was not able to use the stylus.

> I will test patched hid-ntrig.ko tomorrow, with a recompiled kernel, and 
> different patches.

You might want to just grab the hid-ntrig.c file from HEAD:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=drivers/hid/hid-ntrig.c;hb=HEAD

> Nevertheless, I'm interested to contribute both for solving these issue and 
> for improving opensuse/linux tabletPC computing.
> 
> Under linux, we still lack some cool features available on windows, and that 
> is a serious disability to promote our favourite OS on tabletPCs :
> - right-click on delayed touch / stylus pressure, with visual feedback (may be 
> possible with improved linuxwacom / xorg configuration, except for visual 
> feedback ? I saw some xorg.conf with things like "longtouch" ... for evtouch 
> driver ;-/ )
> - multitouch (many things to do, from low-level drivers to KDE integration !)

I'd also like to see something that shows feedback without interfering.  I suspect the xtest extension might be a good place to
start looking.


Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrWvvgACgkQwuRiAT9o608Q8QCgjBaCulVWzvpWrId05I0U7FyZ
Fq8AoPQPlygv/LhRYTuhe4ROnL94ErXs
=1oMY
-----END PGP SIGNATURE-----
