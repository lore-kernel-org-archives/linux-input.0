From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from suspend-to-idle
Date: Tue, 17 Mar 2015 15:39:15 +0100
Message-ID: <19838260.A8ZUqttirU@vostro.rjw.lan>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan> <1902569.dAVq7nl4i8@vostro.rjw.lan> <20150317085033.GC9761@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150317085033.GC9761@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday, March 17, 2015 09:50:33 AM Pavel Machek wrote:
> 
> > > > Yeah, that works too.  And you're right that there's no reason to do that for
> > > > keyboard only.
> > > 
> > > Actually, are you sure?
> > > 
> > > Resuming on mouse click is reasonable, resuming on mouse move is not,
> > > as table vibrations are likely to cause that.
> > 
> > This is disabled by default, so user space has to enable it anyway if it wants
> > to.
> 
> Good. (But still, for suspend-to-RAM, only mouse _click_ will resume
> the machine, as the optical sensor is powered down, no?)

I'm not sure really.  I have mice that resume from suspend-to-RAM on a movement
too, but those are USB.

Rafael

