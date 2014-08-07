From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - use dev_get_drvdata()
Date: Wed, 6 Aug 2014 23:12:18 -0700
Message-ID: <20140807061218.GB651@core.coreip.homeip.net>
References: <1407386457-32587-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44396 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbaHGGMY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Aug 2014 02:12:24 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so4674044pdb.3
        for <linux-input@vger.kernel.org>; Wed, 06 Aug 2014 23:12:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407386457-32587-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Thu, Aug 07, 2014 at 01:40:57AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to first get a platform_device structure in the suspend/resume
> functions. 
> 
> Make the code simpler by calling dev_get_drvdata() directly.

I actually believe that we should be using  the proper accessors fro the type.
The fact that they resolve to the same data object is implementation detail, as
far as I am concerned (unless driver core folks want to deprecate or get rid of
everything but dev_{get|set}_drvdata()).

Thanks.

-- 
Dmitry
