From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: [PATCH 4/8] Input: twl6040-vibra: Check the selected path for vibra
Date: Mon, 26 Sep 2011 09:41:01 +0300
Message-ID: <1701394.KPvkMRlXDI@barack>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com> <1525226.U1fKglfAtr@barack> <20110924060041.GB30648@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:47824 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751280Ab1IZGk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 02:40:58 -0400
In-Reply-To: <20110924060041.GB30648@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

On Friday 23 September 2011 23:00:41 Dmitry Torokhov wrote:
> The application will get an error on read or write, like -ENODEV, and=
 will
> hopefully "drop off".

Thank you for the answer, but I would still like to avoid zapping the i=
nput=20
device runtime for now.
In order to do that, I need to build up some sort of notification infra=
 for=20
the twl6040 vibra (in the MFD driver) to create, and destroy the input =
device=20
depending on the changes in the audio driver.
I'm also concerned about the needed LOC for this to implement, might be=
 too=20
overkill, since I would think that the twl6040 vibra driving method wou=
ld not=20
change runtime in any system.
As a note: the other vibra (twl4030-vibra) does not even let user space=
 know,=20
that it ignored the effect due to the routing selection. Returning -EBU=
SY is a=20
bit better than that.. I know this is not a valid argument for anything=
 ;)

Regards,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
