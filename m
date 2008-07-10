From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESENT] [RFC] gpio-keys: let platform code specify the
	trigger type
Date: Thu, 10 Jul 2008 09:54:26 -0400
Message-ID: <20080710135426.GA3125@anvil.corenet.prv>
References: <1215070080-13755-1-git-send-email-Uwe.Kleine-Koenig@digi.com> <1215680324-32164-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:13199 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYGJNzE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2008 09:55:04 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1063729yxm.1
        for <linux-input@vger.kernel.org>; Thu, 10 Jul 2008 06:55:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1215680324-32164-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: linux-input@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>, David Brownell <dbrownell@users.sourceforge.net>, Herbert Valerio Riedel <hvr@gnu.org>

Hi Uwe,

On Thu, Jul 10, 2008 at 10:58:44AM +0200, Uwe Kleine-K=F6nig wrote:
> The intend for this change is that not all platform's irqs support
> triggering on both edges.  Examples are ns9xxx[1] and txx9[2], and I
> expect that there are more.
>=20
> Provided that the platform data is initialized with zeros there is no
> change in behavior if the new struct member 'trigger' isn't set in
> platform code.
>=20

OK, makes sense. Unfortunately the patch conflicts with debounce suppor=
t
that is in 'next' branch of my tree so I can't apply it as is. Actually=
,
with debounce support is may not even be needed in the present form.

> open points:
>  - if only one trigger direction is used it should match active_low s=
uch
>    that the button press generates the irq.
>  - poll for button release instead of generate the release event
>    directly after the press?

Yes, I think that would be the best option.

>  - is it correct to input_sync() between press and release event?
Yes, button press and release are 2 distinct states of the device and s=
o
it is prudent to have input_sync in between.

>  - sanitize button->trigger &=3D IRQF_TRIGGER_EDGE in gpio_keys_probe
>    before passing it to request_irq?

Would be nice, together with WARN() in case it needed stanitizing.

>  - a comment describing the trigger member of struct gpio_keys_button
>=20
> I'd like to have polling support in this driver.  This could use
> button->trigger =3D=3D 0, so it might be sensible to add a
> WARN_ON(!button->trigger) for now and wait some time before implement=
ing
> it.
>

I am not sure if addin a pure polling mode to this driver is a best
idea. Maybe writing a separate one based on input-polldev will allow
keep them both simpler than combined one.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
