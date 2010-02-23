From: Stefan Achatz <stefan_achatz@web.de>
Subject: Re: [PATCH 3/3] Adding documentation to sysfs attributes of roccat
 kone driver
Date: Tue, 23 Feb 2010 09:03:08 +0100 (CET)
Message-ID: <31758929.1286552.1266912188132.JavaMail.fmail@mwmweb006>
References: <201002200911.53900.stefan_achatz@web.de>
 <20100222062916.GA2095@core.coreip.homeip.net>
 <alpine.LNX.2.00.1002221100130.30967@pobox.suse.cz>
 <201002221942.04624.erazor_de@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:33185 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0BWIDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 03:03:10 -0500
Content-Disposition: inline
In-Reply-To: <201002221942.04624.erazor_de@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, wylda@volny.cz, Pavel Machek <pavel@suse.cz>, Alessandro Guido <ag@alessandroguido.name>, Tomas Hanak <tomas.hanak@gmail.com>, Jason Noble <nobleja@polezero.com>, simon.windows@gmail.com, Sean Hildebrand <silverwraithii@gmail.com>, Sid Boyce <sboyce@blueyonder.co.uk>, Henning Glawe <glaweh@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> Thank you for adding documentation for the sysfs attributes. I have o=
ne
> more request though - the documentation adds a lot of anformation abo=
ut
> whta the fields mean but unfortunately it is silent on _why_ all thes=
e
> fields are needed.

> For example, why weight is interesting? Is it just shown just because=
 we can?
> What woudl yuser do with this information? Why would I need to
> manipulate several profiles instead of letting udev configure desired
> state for me every time mouse is plugged into the box? Should not TCU
> calibration be simply performed during driver binding instead of
> on-demand from userspace? And so forth.

I would have done all with libusb in userspace if I had not some proble=
ms with it:
- devio wouldn't let me access the mouseprofiles because the manufactur=
er uses a way to access them check_ctrlrecip() forbids.
- removing usbhid temporarily would render the mouse not responding for=
 the time the action takes.
- readding usbhid is quirky and one needs to replug the mouse if the so=
ftware fails in some way.

I'm unsure if all this functionality is wanted inside the kernel. This =
device is Hardware for gamers which i find interesting to be supported =
by linux also.
In my attempt to raise acceptance for kernel integration i moved all un=
necessary functionality like calculating real weight and dpi values int=
o my userland tools to keep only the basic functions in the module.
This driver is available as externally compiled module for some months =
now, in my eyes its the most elegant (and the only workable) solution a=
nd these patches are also an attempt to find out if this project genera=
lly has a chance to be integrated in the kernel (but there is also a mo=
dule for sonys ps3 controller).
There are more devices from this manufacturer which have similar functi=
ons like a keyboard with a whole bunch of macro keys where the macros a=
re stored in the keyboard which I find useful as (amateur) programmer a=
nd admin.

The weight is really just a "because I can" value.

Switching the profiles is done via software or pressing a button on the=
 mouse and is useful if you wan't to play games with high sensitivity a=
nd use a low sensitivity profile for detail work in a graphics applicat=
ion. Also different button mappings (the mouse can play macros with can=
 contain keyboard and mouse button events) are useful for different app=
lications. As example some applications (viewers) do pagescroling with =
"page up/down" some with arrow keys. You are free to change profiles in=
 the mouse or load new profiles as you like.
You can use a script to backup profiles and load a whole set of specifi=
c profiles before starting maybe a game and restore the old profiles on=
 exit.

TCU calibration is only needed if you switch the surface the mouse is b=
eing used on. Also you can save and restore already aquired calibration=
 data with the settings attribute without the need of recalibration.

Maybe this answers some of the questions. I'm new to this kernel patchi=
ng stuff and I might benefit from verbatim questions and statements.
Thanks
Stefan Achatz
___________________________________________________________
GRATIS f=C3=BCr alle WEB.DE-Nutzer: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://movieflat.web.de
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
