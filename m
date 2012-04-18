From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
Date: Wed, 18 Apr 2012 08:10:02 +0000
Message-ID: <201204180810.02561.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de> <1334682507-15055-8-git-send-email-stigge@antcom.de> <20120418054615.GB17506@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418054615.GB17506-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wednesday 18 April 2012, Thierry Reding wrote:
> [...]
> > +                     /*
> > +                      * MIC Interrupt controller includes:
> > +                      *   MIC @40008000
> > +                      *   SIC1 @4000C000
> > +                      *   SIC2 @40010000
> > +                      */
> > +                     mic: interrupt-controller@40008000 {
> > +                             compatible = "nxp,lpc32xx-mic";
> > +                             interrupt-controller;
> > +                             interrupt-parent;
> 
> I think in this case you can leave this out. At least there doesn't seem to
> be any other such usage in the tree.
> 

It's actually a bug and we're removing all empty "interrupt-parent"
properties from the dts files now because they cause problems. Please don't
introduce new ones.

	Arnd

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
