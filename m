From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 04 Jun 2011 18:50:02 +0200
Message-ID: <4DEA623A.40507@absence.it>
References: <4DE8FC4A.9010401@absence.it>	<4DE8FFE0.5070506@absence.it>	<20110604084338.GD7194@kamineko.org>	<20110604124219.GA14809@srcf.ucam.org>	<4DEA3FBD.8020602@absence.it>	<20110604143012.GA16615@srcf.ucam.org>	<4DEA4283.103@absence.it>	<20110604143638.GA16747@srcf.ucam.org>	<4DEA4450.80702@absence.it>	<20110604144527.GA16911@srcf.ucam.org> <BANLkTinu=AU4ro6HjF1JZnomsXwNkoz2hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <BANLkTinu=AU4ro6HjF1JZnomsXwNkoz2hg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 04/06/2011 17:04, Corentin Chary ha scritto:
> The last ALS device class attempt didn't went so well,

In fact I had to expose some sysfs nodes in sony-laptop. I don't know 
how other vendors implemented the ALS stuff (I suppose mostly with an hw 
solution), but the software based solution from Sony is quite complex 
and I don't know if it can fit in a generic interface, but we can try. 
However in the meantime I cloned the (nicely working) Windows software 
behavior, with the help of Javier Achirica: by means of the acpi bus and 
a Vaio specific daemon (using some model specific parameters provided by 
the DSDT code and the same lux-to-backlight formula used by the windows 
software from Sony) we managed to have everything working and every 
model supported. Ok, it not the best design (a better one may be 
introduced later), but it works great and now (please consider that 
older ALS equipped models are now 2 years old, so it would be good to 
support them as soon as possible); many people are already happily using 
this solution.
I think there will be a lot to discuss about patch #23.
