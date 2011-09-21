From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/8] ASoC/MFD/Input: twl6040: Support for audio driven vibra
Date: Wed, 21 Sep 2011 16:10:43 +0300
Message-ID: <4087693.7Xef8rW0nd@barack>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42084 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860Ab1IUNKg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Sep 2011 09:10:36 -0400
In-Reply-To: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <samuel.ortiz@intel.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

Hi Samuel, Dmitry,

On Thursday 15 September 2011 15:59:13 Peter Ujfalusi wrote:
> Peter Ujfalusi (8):
>   Input: twl6040: Simplify vibra regsiter definitions
>   MFD: twl6040: Cache the vibra control registers
>   MFD: twl6040: function to query the vibra status for clients
>   Input: twl6040-vibra: Check the selected path for vibra
>   ASoC: twl6040: Fix the number of channels for vibra
>   ASoC: twl6040: Correct supported number of playback channels
>   ASoC: omap-mcpdm: Correct the supported number of channels
>   ASoC: twl6040: Support for vibra output paths

Could you take a look at this series for the MFD/Input parts?

Dmitry: Do you have further comments for patch 4? I will change the err=
or=20
returned to -EBUSY, as Liam was suggesting.

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
