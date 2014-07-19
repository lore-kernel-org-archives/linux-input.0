From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power-managing devices that are not of interest at some point
 in time
Date: Sat, 19 Jul 2014 10:51:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1407191039160.25162-100000@netrider.rowland.org>
References: <1451627.FURGiR949u@dtor-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1451627.FURGiR949u@dtor-glaptop>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrik Fimml <patrikf@chromium.org>, Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 18 Jul 2014, Dmitry Torokhov wrote:

> > The area where it must interact with power management is wakeup, both remote
> > wakeup at run time and wakeup from system suspend.  In particular, there's
> > the question whether or not a device ignoring its input should be regarded
> > as a wakeup source.
> 
> I'd say no.

This raises an interesting question.  Suppose the system gets suspended 
while the lid is closed.  At that point, shouldn't wakeup devices be 
enabled, even if they were already inhibited?

Alan Stern

