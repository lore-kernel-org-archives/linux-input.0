From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 11:13:02 -0700
Message-ID: <20091013181301.GB21593@core.coreip.homeip.net>
References: <1255454163-22179-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:52298 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933974AbZJMSNY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 14:13:24 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so10520307fxm.17
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2009 11:13:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255454163-22179-1-git-send-email-miguel.aguilar@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Miguel,

On Tue, Oct 13, 2009 at 11:16:03AM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> Adds the driver for enabling keypad support for DaVinci platforms.
> 
> DM365 is the only platform that uses this driver at the moment.
> 

Could you please also get rid of davinci_ks_{read,write} - they are
pointless. I promise this is my last request ;)

Also - I wonder who "owns" board-specific code (the one your second
patch is affecting). I usually let arch people to merge it instead of
goping thruogh input tree.

-- 
Dmitry
