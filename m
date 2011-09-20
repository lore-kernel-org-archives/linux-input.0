From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: Re: [alsa-devel] [PATCH 7/8] ASoC: omap-mcpdm: Correct the
 supported number of channels
Date: Tue, 20 Sep 2011 12:35:22 +0100
Message-ID: <20110920113522.GJ2387@opensource.wolfsonmicro.com>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com>
 <20110920105714.GA14609@sirena.org.uk>
 <1661734.tddAioOORG@barack>
 <1703825.IkgE7UOG84@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57609 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752316Ab1ITLfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 07:35:25 -0400
Content-Disposition: inline
In-Reply-To: <1703825.IkgE7UOG84@barack>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>

On Tue, Sep 20, 2011 at 02:24:05PM +0300, P=E9ter Ujfalusi wrote:
> On Tuesday 20 September 2011 14:10:24 P=E9ter Ujfalusi wrote:

> > Hrm, I have used Linus's tree for this series, and AFAIK there were=
 no
> > changes regarding to McPDM apart from the patches I have submitted.

> > Could you give me a hint, why it failed?

> I know why it fails.
> We need to have the new McPDM driver patches for this to apply.

I was about to say I was pretty sure it was due to your driver
rewrite...  Unfortunately I don't have a copy of Liam's tree as it was
hosted on kernel.org and not in -next so I don't have the current state
of the OMAP branches.   Liam, can you push somewhere else or otherwise
send me the latest code?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
