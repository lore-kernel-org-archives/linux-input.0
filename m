From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v2 2/6] MFD: twl6040: Cache the vibra control registers
Date: Wed, 12 Oct 2011 10:53:18 +0300
Message-ID: <2683250.RVKxy9YcCb@barack>
References: <1316760584-27426-1-git-send-email-peter.ujfalusi@ti.com> <1316760584-27426-3-git-send-email-peter.ujfalusi@ti.com> <20111011144824.GE1098@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:40330 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743Ab1JLHxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 03:53:19 -0400
In-Reply-To: <20111011144824.GE1098@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

On Tuesday 11 October 2011 15:48:24 Mark Brown wrote:
> It strikes me that it might be useful to just convert the driver to
> regmap and get cache for everything...

Good idea, I'll take a look at regmap
=20
> Anyway, could you please restructure this series to minimize the
> dependency on the input subsystem?  Then we can get the rest of it
> applied.

Will send the v3 series soon.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
