From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 7/8] Input: docs - split input docs into kernel- and
 user-facing
Date: Sun, 16 Apr 2017 11:08:13 -0300
Message-ID: <20170416110813.66a4ba64@vento.lan>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
        <20170416051145.13618-7-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-7-dmitry.torokhov@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Em Sat, 15 Apr 2017 22:11:44 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> Split input documentation into several groups: kernel- and user-facing, and
> notes about individual device drivers. Move device drivers docs into a
> separate subdirectory.

I reviewed and tested Sphinx generation for this patch series.
Thinks are a way better organized now. Good work!

I got just a minor nitpick for HTML generation (see below).


However, building PDF documentation now hits an error, with Sphinx 1.4.9:

	Markup is unsupported in LaTeX:
	input/devices/xpad:209: literal blocks in footnotes are not supported by LaTeX

It seems it didn't like to have literal blocks inside footnotes:

	.. [4] /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany):

	 ::

	    T:  Bus=01 Lev=03 Prnt=04 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
	    D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=32 #Cfgs=  1
	    P:  Vendor=05fd ProdID=107a Rev= 1.00
	    C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
	    I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=(none)
	    E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
	    E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms


I'll see if I can find a way to fix this issue.

There's something that, IMHO, would also fit better with the input
kAPI documentation, as it complements it:
	Documentation/driver-api/input.rst

It also makes sense to add, at the uAPI book, a:

	.. kernel-doc:: include/uapi/linux/input.h

In order for it to parse the kernel-doc tags there.

I'll prepare some RFC patches with it and see how well it goes.

Jon,

There's something that we need to think about it, and, perhaps
discuss on the next KS, with regards to how things will be better
organized, long term.

Before the ReST conversion, due to the way kernel-docs worked, all
documentation generated from the Kernel sources had to be under
Documentation/DocBook. At the end of the day, that forced that all
kAPI documentation generated from source files to be there.
In the case of drivers, most went to the driver-api book.

During the ReST conversion, when I converted the media documentation, you
pointed me that, on some time, we should be reorganizing the media
documentation, perhaps moving the uAPI documents to driver's API.

Now that we also converted the input documentation to ReST, I'm
seeing that, on other subsystems, there are also uAPI, kAPI and
driver-specific information grouped together.

So, I wonder what would be easier to maintain, long term, and
what would work best for the documentation readers.

I mean: assuming that we finish the ReST conversion, specially for
drivers, we'll end by having at leat 3 major groups of docs, for
every documented subsystem:
	- uAPI;
	- kAPI;
	- driver-specific documentation.

we have two options here:

1) have 3 huge documents:
	- driver-api;
	- driver-userspace-api;
	- driver-specific-docs.

If we would go to this patch, it probably makes sense to have one
sub-dir for each subsystem, e. g.:
	Documentation/driver-api/media
	Documentation/driver-userspace-api/media
	Documentation/driver-specific-docs/media
	Documentation/driver-api/input
	Documentation/driver-userspace-api/input
	Documentation/driver-specific-docs/input
	...

And, at maintainers file, for every subsystem:

MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
...
	F:	Documentation/driver-api/media/
	F:	Documentation/driver-userspace-api/media/
	F:	Documentation/driver-specific-docs/media/

On a side note, just the media documentation, as of today,
generates a 1,000+ PDF book. I suspect that, if we'd go this
way, we'll generate really *huge* PDF files.


2) have one documentation per subsystem, just like the media
documentation is today.

Using my maintainer's hat, the difference from (1) or (2), is not
much: If we take approach (1), I would need to build 3 documents on
Sphinx to be sure that the documentation is OK; with (2), just one
document has everything, so it is easier to check if both PDF and
HTML outputs are fine. It will also build the documentation faster.

However, from the PoV of someone that it is writing a driver or
an userspace application to interact with some subsystem, it is
a way easier to have just one book that would describe such
subsystem, specially if they're using the PDF or ePUB books.

So, IMHO, (2) is better.

Regards,
Maur


> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> index d1a476f973b1..1b6829b74ae8 100644
> --- a/Documentation/input/sentelic.rst
> +++ b/Documentation/input/devices/sentelic.rst
> @@ -1,16 +1,16 @@
>  .. include:: <isonum.txt>
>  
> -===============
> -Sentelic Driver
> -===============
> +=================
> +Sentelic Touchpad
> +=================
>  
>  
>  :Copyright: |copy| 2002-2011 Sentelic Corporation.
>  
>  :Last update: Dec-07-2011
>  
> -Finger Sensing Pad Intellimouse Mode(scrolling wheel, 4th and 5th buttons)
> -==========================================================================
> +Finger Sensing Pad Intellimouse Modei (scrolling wheel, 4th and 5th buttons)
> +============================================================================

Nitpick: I guess there's a typo here:
		Modei -> Mode




Thanks,
Mauro
