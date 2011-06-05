From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sun, 05 Jun 2011 19:48:06 +0200
Message-ID: <4DEBC156.1030503@absence.it>
References: <4DE8FC4A.9010401@absence.it>	<4DE8FFE0.5070506@absence.it>	<20110604084338.GD7194@kamineko.org>	<20110604124219.GA14809@srcf.ucam.org>	<4DEA3FBD.8020602@absence.it>	<20110604143012.GA16615@srcf.ucam.org>	<4DEA4283.103@absence.it>	<20110604143638.GA16747@srcf.ucam.org>	<4DEA4450.80702@absence.it> <20110604212249.568e76b6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110604212249.568e76b6@lxorguk.ukuu.org.uk>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 04/06/2011 22:22, Alan Cox ha scritto:

> The longer term plan is to stick all kinds of device sensors (as distinct
> from input devices) into the IIO layer but that is still in staging and
> seems to have no clear plan of date for migration yet. However Jonathan
> (the maintainer) also doesn't seem too keen on owning them either
>
> http://lkml.org/lkml/2010/3/3/378
>
> All in all ALS is a bit of a disaster area.

So, what to do now? I'm not sure that the IIO layer is always fine when 
dealing with notbooks. For example, on every ALS equipped Vaio notebook, 
setting the notebook to generate ALS events will also result in _BCM no 
longer applying any further backlight change, it will instead generate 
another ACPI event when calling (this allows to have, in userspace, a 
single piece of software mixing and applying coherently both ALS driven 
and user driven backlight corrections).
On newer Vaios, the ALS sensor is totally controlled by the EC, so we 
just have the illuminance reading and talking about "device driver" 
don't make much sense (we'd better have an ALS device class). I don't 
know how other vendors introduced this functionality, but I can imagine 
that many different implementation are present across different models 
or brands. We need a solution, now, because there are lots of notebooks 
with these tiny but useful sensors, and people do want to use them.
