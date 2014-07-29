From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/7] Second batch of cleanups for cros_ec
Date: Tue, 29 Jul 2014 14:27:20 +0200
Message-ID: <53D79328.8060609@suse.de>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Javier,

Am 28.07.2014 14:19, schrieb Javier Martinez Canillas:
> The patches in this series are authored by different people
> (all on cc) and consist of the following:
>=20
> Andrew Bresticker (3):
>   mfd: cros_ec: stop calling ->cmd_xfer() directly
>   mfd: cros_ec: move locking into cros_ec_cmd_xfer
>   mfd: cros_ec: wait for completion of commands that return IN_PROGRE=
SS
>=20
> Derek Basehore (1):
>   i2c: i2c-cros-ec-tunnel: Set retries to 3
>=20
> Doug Anderson (1):
>   mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
>=20
> Todd Broch (2):
>   mfd: cros_ec: Instantiate sub-devices from device tree
>   Input: cros_ec_keyb: Optimize ghosting algorithm.

When you submit other people's patches, I believe you still need to sig=
n
them off as submitter. In particular when you rebased them.

Regards,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
