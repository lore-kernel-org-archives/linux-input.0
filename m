From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V2 03/10] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Date: Tue, 29 Nov 2016 11:15:38 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCEC304@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource@diasemi.com>
 <20161129005927.GA1848@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161129005927.GA1848-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Eduardo,

On 29 November 2016 00:59, Eduardo Valentin, wrote:
> On Wed, Oct 26, 2016 at 05:56:37PM +0100, Steve Twiss wrote:
> > +Optional properties:
> > +
> > +- dlg,tjunc-temp-polling-period-ms : Specify the polling period, measured
> > +    in milliseconds, between thermal zone device update checks.
> 
> Can you please elaborate on why you need this chip manufacture specific
> property?
> 
> Can we use the polling property of already existing in the
> Documentation/devicetree/bindings/thermal/thermal.txt
> 
> See the polling properties.

[...]
> > +			dlg,tjunc-temp-polling-period-ms = <3000>;

Agreed. There is a polling period built into the thermal core. I've discussed my
reasoning for this decision in answer to your other e-mail. Please refer to the
other discussion thread: https://lkml.org/lkml/2016/11/29/262

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
