From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on	MACH_MAINSTONE instead of ARCH_PXA
Date: Tue, 17 Jun 2008 12:58:41 +0100
Message-ID: <20080617115835.GA16002@sirena.org.uk>
References: <48564133.3070609@gmail.com> <20080616120756.GA7302@rakim.wolfsonmicro.main> <48570E1E.3070301@gmail.com> <20080617095928.GD6114@rakim.wolfsonmicro.main> <4857A577.5030506@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1543 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbYFQL6r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 07:58:47 -0400
Content-Disposition: inline
In-Reply-To: <4857A577.5030506@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input <linux-input@vger.kernel.org>

On Tue, Jun 17, 2008 at 02:52:23PM +0300, Mike Rapoport wrote:

> Probably something like the patch below may allow passing platform data at least
> for ASoC devices:

This needs to be something that can be used on all AC97 systems, not
just ASoC ones (people use these devices on things like x86 too, for
example).  The last time someone proposed something to deal with this
the ALSA maintainers were very reluctant to allow any sort of void *
through the AC97 bus which stalled everything.
