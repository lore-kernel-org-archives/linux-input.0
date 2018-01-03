From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input
 device
Date: Wed, 03 Jan 2018 02:43:32 +0100
Message-ID: <1514943812.2523.24.camel@hadess.net>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
         <1483370825.2420.8.camel@hadess.net> <201701021809.58943@pali>
         <1483442481.2420.12.camel@hadess.net>
         <20180102214852.pnsocg7qaxt5y6qh@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:40425 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeACBnj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 20:43:39 -0500
In-Reply-To: <20180102214852.pnsocg7qaxt5y6qh@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2018-01-02 at 22:48 +0100, Pali Rohár wrote:
> On Tuesday 03 January 2017 12:21:21 Bastien Nocera wrote:
> > On Mon, 2017-01-02 at 18:09 +0100, Pali Rohár wrote:
> > > On Monday 02 January 2017 16:27:05 Bastien Nocera wrote:
> > > > On Sun, 2016-12-25 at 11:04 +0100, Pali Rohár wrote:
> > > > > This patch allows user to disable events from any input
> > > > > device so
> > > > > events
> > > > > would not be delivered to userspace.
> > > > >  
> > > > > Currently there is no way to disable particular input device
> > > > > by
> > > > > kernel.
> > > > > User for different reasons would need it for integrated PS/2
> > > > > keyboard or
> > > > > touchpad in notebook or touchscreen on mobile device to
> > > > > prevent
> > > > > sending
> > > > > events. E.g. mobile phone in pocket or broken integrated PS/2
> > > > > keyboard.
> > > > >  
> > > > > This is just a RFC patch, not tested yet. Original post about
> > > > > motivation
> > > > > about this patch is there: https://lkml.org/lkml/2014/11/29/9
> > > > > 2
> > > > 
> > > >  
> > > > Having implemented something of that ilk in user-space (we
> > > > automatically disable touch devices when the associated screen
> > > > is
> > > > turned off/suspended), I think this might need more thought.
> > > 
> > > How to implement such thing in userspace? I think you cannot do
> > > that 
> > > without rewriting every one userspace application which uses
> > > input.
> > > 
> > > > What happens when a device is opened and the device disabled
> > > 
> > > through
> > > > sysfs, are the users revoked?
> > > 
> > > Applications will not receive events. Same as if input device
> > > does
> > > not 
> > > generates events.
> > > 
> > > > Does this put the device in suspend in the same way that
> > > > closing
> > > 
> > > the
> > > > device's last user does?
> > > 
> > > Current code not (this is just RFC prototype), but it should be
> > > possible 
> > > to implement.
> > > 
> > > > Is this not better implemented in user-space at the session
> > > > level,
> > > > where it knows about which output corresponds to which input
> > > 
> > > device?
> > > 
> > > How to do that without rewriting existing applications?
> > > 
> > > > Is this useful enough to disable misbehaving devices on
> > > > hardware,
> > > 
> > > so
> > > > that the device is not effective on boot?  
> > > 
> > > In case integrated device is absolutely unusable and generates
> > > always 
> > > random events, it does not solve problem at boot time.
> > > 
> > > But more real case is laptop with closed LID press buttons and
> > > here
> > > it 
> > > is useful.
> > 
> > There's usually a display manager in between the application and
> > the
> > input device.
> 
> But that is not always truth. In some cases there are applications
> which
> opens input device directly.

Which is why I said "usually", and not "always".

> > Whether it's X.org, or a Wayland compositor. Even David's
> >  https://github.com/dvdhrm/kmscon could help for console
> > applications.
> 
> That kmscon needs KMS, right? So it would not work on hardware which
> do
> not have KMS drivers.

Except that the use cases are getting smaller and smaller. At one
point, it might become easier to carry that patch in your tree, for
your use case.

It's not useful on desktop Linux, it's not useful for Android or Chrome
OS. It seems it's only really useful for the console when there's no
way to use a display manager between the console subsystem and the
"UI".

At this point I'd ask whether whatever is consuming those buttons can't
be modified instead of the kernel. You'd even get the benefit of being
able to close devices and save some power.
