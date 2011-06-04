From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 21:22:49 +0100
Message-ID: <20110604212249.568e76b6@lxorguk.ukuu.org.uk>
References: <4DE8FC4A.9010401@absence.it>
	<4DE8FFE0.5070506@absence.it>
	<20110604084338.GD7194@kamineko.org>
	<20110604124219.GA14809@srcf.ucam.org>
	<4DEA3FBD.8020602@absence.it>
	<20110604143012.GA16615@srcf.ucam.org>
	<4DEA4283.103@absence.it>
	<20110604143638.GA16747@srcf.ucam.org>
	<4DEA4450.80702@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4DEA4450.80702@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 04 Jun 2011 16:42:24 +0200
Marco Chiappero <marco@absence.it> wrote:

> Il 04/06/2011 16:36, Matthew Garrett ha scritto:
> > On Sat, Jun 04, 2011 at 04:34:43PM +0200, Marco Chiappero wrote:
> >
> >> Ok, fine. So, should we forward any event (als events, shock
> >> protection, hybrid GFX, etc.) to the input core then?
> >
> > als events and shock protection probably ought to be uevents on the
> > appropriate device.
> 
> More precisely? As far as I know there is no ALS device class; and I 
> know nothing about the other.

Start reading around here

http://lkml.org/lkml/2010/3/3/334

(and the earlier threads on the ALS class which Linus rejected)

I'd like to see an ALS class but it seems the head penguin won't accept
one, so we now have a zillion incompatible light sensors mostly out of
tree because nobody can be bothered to have the argument again.

The longer term plan is to stick all kinds of device sensors (as distinct
from input devices) into the IIO layer but that is still in staging and
seems to have no clear plan of date for migration yet. However Jonathan
(the maintainer) also doesn't seem too keen on owning them either

http://lkml.org/lkml/2010/3/3/378

All in all ALS is a bit of a disaster area.

Alan
