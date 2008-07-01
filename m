From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack reporting v2
Date: Tue, 1 Jul 2008 10:24:36 +0100
Message-ID: <20080701092435.GA9730@sirena.org.uk>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com> <20080603104048.GA17007@rakim.wolfsonmicro.main> <20080603105920.ZZRA012@mailhub.coreip.homeip.net> <20080603233813.GA30512@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3574 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYGAJYj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 05:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20080603233813.GA30512@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Wed, Jun 04, 2008 at 12:38:14AM +0100, Mark Brown wrote:

> There is an additional motivation for using an input device for jacks -
> it is common to support a button implemented by shorting the microphone
> connection as well as simply detecting the presence of something in the
> jack.

Hi Dimitry,

Do you have any further thoughts on this?  I'd really like to get this
in during 2.6.28 if possible but it really needs your feedback.

Thanks,
Mark
