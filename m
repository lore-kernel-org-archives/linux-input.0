From: "DISTEC Inan, Ahmet" <Inan-T/gOFcTbiWqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Fri, 6 Oct 2017 09:43:02 +0200
Message-ID: <20171006074302.cqo6vfkbl54n4txc@dev-ai1.datadisplay.de>
References: <20170928152317.19098-1-inan@distec.de>
 <20171005232228.5m2mxxtdkgavnrs6@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171005232228.5m2mxxtdkgavnrs6@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ahmet Inan <xdsopl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dear Rob,

> >  .../bindings/input/touchscreen/exc3000.txt         |  27 ++++
> 
> Please split to separate patch.

done.

> > +	exc3000@2a {
> 
> touchscreen@2a

done.

> > +		interrupts = <9 8>; // active low level-sensitive
> 
> Use the defines for flags.

done.

I've sent two new patches.

Best Regards,

Ahmet
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
