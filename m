From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 1/5] misc: Driver for bh1770glc / sfh7770 ALS and
 proximity sensor
Date: Tue, 26 Oct 2010 10:47:48 -0400
Message-ID: <AANLkTikWvRKzr+kffcpTHTs3q3TLeUPzdwzuQSR_tSU2@mail.gmail.com>
References: <1287472188-10101-1-git-send-email-samu.p.onkalo@nokia.com>
	<1287472188-10101-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287472188-10101-2-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

010/10/19 Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>:

> This is a driver for ROHM BH1770GLC and OSRAM SFH7770 combined
> ALS and proximity sensor.
>
> Interface is sysfs based. The driver uses interrupts to provide new d=
ata.
> The driver supports pm_runtime and regulator frameworks.
> (...)
> +static DEVICE_ATTR(prox0_raw_en, S_IRUGO | S_IWUSR, bh1770_prox_enab=
le_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bh1770_prox_enable_store);
> +static DEVICE_ATTR(prox0_thresh_above1_value, S_IRUGO | S_IWUSR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bh1770_prox_abs_thres_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bh1770_prox_abs_thres_store);
> +static DEVICE_ATTR(prox0_thresh_above0_value, S_IRUGO | S_IWUSR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bh1770_get_prox_thres,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bh1770_set_prox_thres);
> +static DEVICE_ATTR(prox0_raw, S_IRUGO, bh1770_prox_result_show, NULL=
);

So you have sysfs entries for enabling, calibrating hysteris
(above/below) and the reading the raw value which I assume
will be 0 (if nothing is in proximity) or 1 (if it is in proximity).

These entries are pretty OK I think, but the transition from
0 to 1 which I assume will generate an interrupt and generate
a new value in this attribute.

But should it not hook into the input framework and generate
a SW_FRONT_PROXIMITY event as well?

I think this could be pretty helpful for generic userspace
applications like X that want to use this event.

Of course I can send a patch for this later, but I'd like
to hear whether you agree on this or not.

Yours,
Linus Walleij
