From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Thu, 8 May 2014 10:17:16 +0200
Message-ID: <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
	<1398947374-3115-9-git-send-email-carlo@caione.org>
	<20140503010936.GF4090@lukather>
	<CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
	<20140505225139.GD9464@lukather>
	<CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
	<20140508025337.GI7047@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBDP3VSNQKGQEFV7RSEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140508025337.GI7047@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, wens Tsai <wens-jdAy2FN1RRM@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, May 8, 2014 at 4:53 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

<snip>

> What I mean is that no information is still better than wrong
> informations. If you don't have the schematics, then don't do anything
> on this boards. Hopefully, someone with more infos on this will know
> what to do.

I partially agree here. Not specifying the voltage range for the
regulators but only keeping them always-on from a practical point of
view means that we do nothing with those regulators (see also
https://www.mail-archive.com/linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg09532.html
)

> Moreover, I have the feeling that you just copy pasted all the
> informations on this patch. The first example I'm seeing is the
> cubieboard, for which we do have the schematics, and this patch says
> that ldo4 is used for HDMI, and that is required to stays always on,
> while LDO4 doesn't seem to be used at all, and that HDMI takes
> directly its input source from DC-5V.

The names for the regulators are taken from the original Allwinner
driver and (of course) they can have nothing to do with the function
they have in the board. I agree that this could be misleading so I'll
change them with more general names. Concerning LDO4 that is always
on, it was off until this v4, but I changed it back to have one common
DT representation among all the boards.

> I guess you need some more refining on this patch.

Ok, I'll submit a v6 only for this patch.

Thanks,

-- 
Carlo Caione
