From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Re: [PATCH 4/8] Input: twl6040-vibra: Check the selected path
 for vibra
Date: Fri, 23 Sep 2011 23:00:41 -0700
Message-ID: <20110924060041.GB30648@core.coreip.homeip.net>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
 <1316091561-30899-5-git-send-email-peter.ujfalusi@ti.com>
 <20110916062719.GB6731@core.coreip.homeip.net>
 <1525226.U1fKglfAtr@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51419 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab1IXGAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Sep 2011 02:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1525226.U1fKglfAtr@barack>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

On Fri, Sep 16, 2011 at 09:42:16AM +0300, P=E9ter Ujfalusi wrote:
> On Thursday 15 September 2011 23:27:20 Dmitry Torokhov wrote:
> > This is not very helpful for the application trying to use the devi=
ce.
> > Maybe we should zap the device when channels are routed through aud=
io
> > instead of dripping requests?
>=20
> Yes, I have thought about that as well, but it can cause other proble=
ms.
> I have modified the fftest tool from:
> http://www.koders.com/c/fidF60D5962FCA8B937A6D0947AA81AE95A8C58FB36.a=
spx
> for my needs.
> It opens the /dev/input/eventX, and it will keep it open as long as i=
t is=20
> running.
> It is OK for me, since the twl6040-vibra goes to low power mode when =
we do not=20
> have effects running.
> I can imagine, that real world application will do the same, and that=
 might=20
> cause some problems, if I try to zap the device.
> Can we zap a device, while it is open?
> How application will handle that event?

The application will get an error on read or write, like -ENODEV, and w=
ill
hopefully "drop off".

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
