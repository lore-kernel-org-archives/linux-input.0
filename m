From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] include: dt-binding: input: create a DT header
 defining key codes.
Date: Mon, 12 Aug 2013 10:15:04 -0700
Message-ID: <20130812171504.GA31418@core.coreip.homeip.net>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
 <52014E50.6030508@wwwdotorg.org>
 <5203D138.4030107@nvidia.com>
 <20130808171331.GA6960@core.coreip.homeip.net>
 <5203D487.5020507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5203D487.5020507-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 08, 2013 at 11:25:27AM -0600, Stephen Warren wrote:
> On 08/08/2013 11:13 AM, Dmitry Torokhov wrote:
> > On Thu, Aug 08, 2013 at 10:41:20PM +0530, Laxman Dewangan wrote:
> >> On Wednesday 07 August 2013 12:58 AM, Stephen Warren wrote:
> >>> (CC'ing DT bindings maintainers too, hence quoting a bit of the patch)
> >>>
> >>> On 08/06/2013 08:12 AM, Laxman Dewangan wrote:
> >>>> Many of Key device tree bindings uses the constant number as key code
> >>>> which matches with kernel header key code and then comment as follows
> >>>> for reference/better readability:
> >>>> 	linux,code = <102>; /* KEY_HOME */
> >>>>
> >>>> Create a DT header which defines all the key code so that DT key bindings
> >>>> can use it as follows:
> >>>> 	linux,code = <KEY_HOME>;
> ...
> > I am uncomfortable that we are duplicating the whole list of keycodes
> > here. Do you think we could split keycodes and other event codes from
> > include/uapi/linux/input.h into include/uapi/linux/input-events.h and
> > unclude it directly into DTS?
> 
> Device tree files can only include headers in include/dt-bindings.
> Eventually/soon, all the DT files and the headers in the dt-bindings/
> directory will be split out into a separate git tree, which does not
> have access to include/uapi, or indeed any other Linux kernel header files.

OK, that makes it easier for me - please merge through whatever tree
that owns include/dt-bindings.

Thanks.

-- 
Dmitry
