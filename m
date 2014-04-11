From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Fri, 11 Apr 2014 15:16:09 +0200
Message-ID: <4702508.rsJyuQngOj@wuerfel>
References: <1397209093-10077-1-git-send-email-carlo@caione.org> <235623053.nj0gFkxyW5@wuerfel> <20140411120908.GC28800@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBRGWT6NAKGQEGFYPHJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140411120908.GC28800-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Friday 11 April 2014 13:09:08 Mark Brown wrote:
> On Fri, Apr 11, 2014 at 01:25:03PM +0200, Arnd Bergmann wrote:
> 
> > Why do you have to enumerate the interrupts here? Can't you just
> > put all the numbers into the DT nodes of the devices using them?
> 
> > In general, I would say that the mfd driver should not care about
> > what is connected to it.
> 
> This then means that all the machines using the device need to define
> the interrupt table and have the MFD cells represented in the DT which
> means encoding Linux abstractions into the DT.
> 
> In cases where the device is also used with ACPI or platform data that's
> a definite issue since they have different idioms.  That applies less to
> PMICs tightly bound to particular SoCs but is an issue in general, not
> all the world is DT.
> 
> There's also issues here with us changing our subsystems.  Things like
> clocks are a bit indistinct at present, they're sort of floating between
> clock and other subsystems.  We've also done things like invent extcon,
> making completely new subdevices.  Keeping the data out of DT avoids
> problems when this happens.  The balance changes a bit if there are
> clearly reusable IPs within the device but sadly hardware designers
> don't always give us that and even then sometimes we don't want to use
> them like that.

Ok, fair enough.

	Arnd
