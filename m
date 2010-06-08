From: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Tue, 8 Jun 2010 14:49:43 +0200
Message-ID: <201006081449.45626.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <20100607161920.GA7706@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100607161920.GA7706-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Monday 07 June 2010, Dmitry Torokhov wrote:
> On Mon, Jun 07, 2010 at 03:13:29PM +0200, Oliver Neukum wrote:
> > Hi,
> >
> > this patch series implements:
> >
> > - full support for suspend/resume/reset_resume
> > - runtime power management
> >
> > It does so by adding normal methods for suspend/resume,
> > splitting device intialization into a part that needs to be repeated
> > after reset_resume() and a part that does not.
> > Runtime power management is possible while the device is
> > active if the device supports remote wakeup, otherwise a fallback
> > to a method based on open/close is implemented.
> >
> > I lack the hardware. Therefore I need testers.
>
> Ondrej,
>
> You are the latest person I know who users usbtouchscreen driver, any
> chance you could lend a hand to Oliver here, please?

I can test Nexio and IRTOUCHSYSTEMS. After I fix the fscking broken Intel KMS 
driver...


-- 
Ondrej Zary
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
