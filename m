From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Tue, 17 Jan 2017 12:07:11 +0100
Message-ID: <20170117110711.GA26116@xo-6d-61-c0.localdomain>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
 <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483442481.2420.12.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> > > > This is just a RFC patch, not tested yet. Original post about
> > > > motivation
> > > > about this patch is there: https://lkml.org/lkml/2014/11/29/92
> > > 
> > > Having implemented something of that ilk in user-space (we
> > > automatically disable touch devices when the associated screen is
> > > turned off/suspended), I think this might need more thought.
> > 
> > How to implement such thing in userspace? I think you cannot do that 
> > without rewriting every one userspace application which uses input.

> > In case integrated device is absolutely unusable and generates
> > always 
> > random events, it does not solve problem at boot time.
> > 
> > But more real case is laptop with closed LID press buttons and here
> > it 
> > is useful.
> 
> There's usually a display manager in between the application and the
> input device. Whether it's X.org, or a Wayland compositor. Even David's
>  https://github.com/dvdhrm/kmscon could help for console applications.

We'd really like it to work on plain old text console, too, because that's what
I'm using on n900, and with old maemo userspace, because that's what everyone
else uses.

You mentioned you think X.org can do this kind of device disabling (and powersave).
Would you have an idea how to activate that? I'd like to disable touchscreen
and most of the buttons when the device is "in the pocket".

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
