From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 4/8] Input: twl6040-vibra: Check the selected path for vibra
Date: Fri, 16 Sep 2011 09:42:16 +0300
Message-ID: <1525226.U1fKglfAtr@barack>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com> <1316091561-30899-5-git-send-email-peter.ujfalusi@ti.com> <20110916062719.GB6731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:56290 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752644Ab1IPGmT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 02:42:19 -0400
In-Reply-To: <20110916062719.GB6731@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

On Thursday 15 September 2011 23:27:20 Dmitry Torokhov wrote:
> This is not very helpful for the application trying to use the device=
=2E
> Maybe we should zap the device when channels are routed through audio
> instead of dripping requests?

Yes, I have thought about that as well, but it can cause other problems=
=2E
I have modified the fftest tool from:
http://www.koders.com/c/fidF60D5962FCA8B937A6D0947AA81AE95A8C58FB36.asp=
x
for my needs.
It opens the /dev/input/eventX, and it will keep it open as long as it =
is=20
running.
It is OK for me, since the twl6040-vibra goes to low power mode when we=
 do not=20
have effects running.
I can imagine, that real world application will do the same, and that m=
ight=20
cause some problems, if I try to zap the device.
Can we zap a device, while it is open?
How application will handle that event?

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
