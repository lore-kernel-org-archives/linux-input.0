From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
Date: Thu, 5 May 2016 11:44:38 -0700
Message-ID: <20160505184438.GA25689@dtor-ws>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160406173140.GB38452@dtor-ws>
 <CAGVrzcbCZn6RYFwJTkffkct1DiiG+tBJnKELDn32T38_s5mjOg@mail.gmail.com>
 <CAAFb_vp+oxHc6YD24zPr0o6Pt9Jt1_LsT14VUQGBKXBpvNAj_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAFb_vp+oxHc6YD24zPr0o6Pt9Jt1_LsT14VUQGBKXBpvNAj_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Raveendra Padasalagi <raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Raveendra,

On Thu, May 05, 2016 at 11:17:00AM +0530, Raveendra Padasalagi wrote:
> Thanks Dmitry and Florian.
> 
> Hi Dmitry,
> 
> I understand the dts changes are really needed for the touch screen
> driver changes made in this patch. But currently there are no deployed
> systems/customer's using this driver. So please pull the driver changes
> and I will follow up to make sure dts changes also goes in.
> 
> Below is the latest patch set pushed.
> 
> https://lkml.org/lkml/2016/3/24/45

I have the driver, binding doc changes, and changes to
arch/arm/boot/dts/bcm-cygnus.dtsi as
74813cebd678dd471b4fcd7d3019aecab9dbcedd in my 'next' branch, so it will
be merged in the next merge window.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
