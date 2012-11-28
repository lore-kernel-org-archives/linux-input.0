From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 23:11:32 -0800
Message-ID: <20121128071132.GE23378@core.coreip.homeip.net>
References: <1354020025-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1354020025-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121127195644.GA29727@core.coreip.homeip.net>
 <20121127200001.GJ4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:40066 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab2K1HLg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 02:11:36 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4624948dak.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 23:11:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121127200001.GJ4468@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Nov 27, 2012 at 08:00:02PM +0000, Mark Brown wrote:
> On Tue, Nov 27, 2012 at 11:56:44AM -0800, Dmitry Torokhov wrote:
> 
> > How do you want to merge it? My tree or some other?
> 
> I'm not terribly fussed but I guess as it's a new driver for the input
> tree merging via ASoC will minimise the potential for conflicts?  But
> we're near the merge window and I'm not sure that's likely anyway so if
> you want to apply it to your tree.

No, going through ASoc tree is fine with me. But given that it is a new
driver I think we should merge it quickly, especially since merge window
hasn't opened yet.

-- 
Dmitry
