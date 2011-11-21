From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH v2 0/2] some updates for newer elantech touchpads
Date: Mon, 21 Nov 2011 17:29:12 +0800
Message-ID: <87fwhhj02f.fsf@emc.com.tw>
References: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw> <20111121063725.GB20521@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:64507 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab1KUJbO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 04:31:14 -0500
In-Reply-To: <20111121063725.GB20521@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org

Hi Dmitry,

On Sun, 20 Nov 2011 22:37:25 -0800, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Mon, Nov 21, 2011 at 01:53:04PM +0800, JJ Ding wrote:
> > Hi,
> > 
> > These two are my last pending patches for newer elantech touchpads.
> > The first patch adds support for a shorter and faster send_cmd, available
> > since v3 hardware. The other one teaches the driver to query resolution
> > data from v4 hardware.
> > 
> > Patches are against Dmitry's current -next tree.
> > 
> > Any comment is welcome, thank you very much.
> > 
> > Change in v2:
> >  - allow resolution query to fail, print a warning if so. (Daniel)
> > 
> 
> Applied both, thanks JJ.

Thank you for taking these patches.

jj
> 
> -- 
> Dmitry
