From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 6/7] mfd: cros_ec: Instantiate sub-devices from device
 tree
Date: Tue, 29 Jul 2014 14:34:41 +0200
Message-ID: <53D794E1.1090003@suse.de>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk> <1406549967-21291-7-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406549967-21291-7-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Javier,

Am 28.07.2014 14:19, schrieb Javier Martinez Canillas:
> From: Todd Broch <tbroch@chromium.org>
>=20
> If the EC device tree node has sub-nodes, try to instantiate them as
> MFD sub-devices.  We can configure the EC features provided by the bo=
ard.
>=20
> Signed-off-by: Todd Broch <tbroch@chromium.org>

This is provoking the blunt question: What sub-devices is it good for?
I.e., do you have a matching DT patchset that adds such devices?

In particular I'm wondering whether that would help with the tps65090 o=
n
Spring? It's a "power-regulator" sub-node of cros-ec in 3.8.

Thanks,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
