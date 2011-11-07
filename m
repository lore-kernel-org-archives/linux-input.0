From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: Re: elantech touchpad problem (long)
Date: Mon, 07 Nov 2011 14:03:01 +0100
Message-ID: <9720202.rmyIglRAGy@fb07-iapwap2>
References: <6476830.8pz05UnHgs@ax5200p> <87fwi0fppd.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:35337 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754394Ab1KGNDL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2011 08:03:11 -0500
In-Reply-To: <87fwi0fppd.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>

Hi Jj,

Am Montag, 7. November 2011, 13:48:14 schrieb JJ Ding:
> On Sat, 05 Nov 2011 22:57:38 +0100, Marc Dietrich <marvin24@gmx.de> wrote:
> > Hi,
> > 
> > my small arm netbook contains a elantech touchpad. It is connected via a
> > keyboard controller which communicates over a i2c bus with the host cpu. The
> > keyboard controller/host cpu communication is handled by a special driver (see
> > drivers/staging/nvec_ps2.c). Up to commmit 28f49616 (Input: elantech - add v3
> > hardware support) the touchpad was recognized as a Logitech mouse and it
> > worked fine this way.
> > 
> > Since commit 28f49616, the touchpad is detected as an elantech device (I
> > checked the hw and it is really one). The detected HW version is 2 and the
> > firmware version 0x150500). Unfortunately, the device still streams 3 byte
> > packets which are of course not handled by the elantech driver.
> 
> I thought we never shipped 0x150500, but obviously I was wrong.
> 
> In current version of Elantech driver, the hw_version detection is done
> in elantech_set_properties(), and it's done this way:
> 
> 	int ver = (etd->fw_version & 0x0f0000) >> 16;
> 
> 	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
> 		etd->hw_version = 1;
> 	else if (etd->fw_version < 0x150600)
> 		etd->hw_version = 2;
> 	else if (ver == 5)
> 		etd->hw_version = 3;
> 	else if (ver == 6)
> 		etd->hw_version = 4;
> 	else
> 		return -1;
> 
> This "ver" integer really means the version of the IC body, and the
> magic number 0x150600 is from an old version of our internal driver
> maintained by Tom Lin <tom_lin@emc.com.tw> (also CCed). Your touchpad
> seems to be a v3 hardware, but due to the fw_version(0x150500) less then
> the magic number, it's treated as a v2 by driver.
> 
> For now, could you please try the below patch? I think I will have to do
> some history homework and ask our senior firmware guys to come up with
> a correct patch.

you are right, patch makes the touchpad working. Somehow I only tested hardcoded v1 
and forgot to test v3. I hope this can still be included in 3.2.

Thanks for help!

Marc

> >From 660a96f7a6d7591054b0ef13aa02c41084b1d7f0 Mon Sep 17 00:00:00 2001
> 
> From: JJ Ding <jj_ding@emc.com.tw>
> Date: Mon, 7 Nov 2011 12:57:50 +0800
> Subject: [PATCH] Input: elantech: adjust hw_version detection logic
> 
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 09b93b1..fa64c3e 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1214,7 +1214,7 @@ static int elantech_set_properties(struct elantech_data *etd)
> 
>  	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
>  		etd->hw_version = 1;
> -	else if (etd->fw_version < 0x150600)
> +	else if (etd->fw_version < 0x150000)
>  		etd->hw_version = 2;
>  	else if (ver == 5)
>  		etd->hw_version = 3;
> 
> ...


