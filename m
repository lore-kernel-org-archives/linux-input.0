From: Dmitry Torokhov <dtor@google.com>
Subject: Re: Power-managing devices that are not of interest at some point in time
Date: Thu, 17 Jul 2014 09:59:19 -0700
Message-ID: <3088260.XkiUM6Vtxh@dtor-glaptop>
References: <Pine.LNX.4.44L0.1407171029210.1517-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1407171029210.1517-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bastien Nocera <hadess@hadess.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrik Fimml <patrikf@chromium.org>, linux-pm@vger.kernel.org, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday, July 17, 2014 10:39:16 AM Alan Stern wrote:
> On Wed, 16 Jul 2014, Dmitry Torokhov wrote:
> > We are not planning on implementing the policy in kernel, that's
> > indeed task for userspace; but unless we bring in the heavy hammer of
> > forcibly unbinding drivers, we do not currently have universal
> > mechanism of quiescing devices.
> 
> We sort of do: the ->freeze() callback.  But it wasn't intended for
> this kind of use; drivers may very well expect that userspace will
> already be frozen when the callback runs.  Besides, ->freeze() is
> supposed to quiesce devices without powering them down, whereas you
> want to do both.

Right.

> 
> What you're asking for is different from anything the PM subsystem has
> done before.

Right.

> Given this fact, I don't see any alternatives to adding a
> new API or repurposing an existing API.  Either one would be somewhat
> painful.
> 
> For example, we could arrange to invoke ->suspend().  However, since
> the circumstances would be unusual (userspace is still running,
> ->prepare() was not called beforehand, ->suspend_irq() won't be called
> afterward), subsystems and drivers may very well react inappropriately.

I do not think anybody expects that drivers would not have to be modified to 
support this functionality; I expect drivers would have to declare themselves 
"queiscable" and therefore would assert that they will act according to 
whatever rules we set up. I only want to make sure that this new state is 
added to existing list of PM states rather than creating completely new 
facility, so that driver authors have a chance to understand PM state 
transitions that involve their driver. 

Thanks,
Dmitry

