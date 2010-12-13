From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Mon, 13 Dec 2010 00:51:43 -0800
Message-ID: <20101213085143.GE21401@core.coreip.homeip.net>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:52279 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0LMIvz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 03:51:55 -0500
Received: by iwn6 with SMTP id 6so8814355iwn.1
        for <linux-input@vger.kernel.org>; Mon, 13 Dec 2010 00:51:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, ext-phil.2.carmody@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi Srikar,

On Thu, Nov 25, 2010 at 05:45:13PM +0200, Srikar wrote:
> From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> 
> Discussions: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26748.html
> 
> Introduce a driver for the Texas Instruments TSC2005 touchscreen
> controller (http://focus.ti.com/docs/prod/folders/print/tsc2005.html).
> 
> The patch is based on a driver by Lauri Leukkunen, with modifications
> by David Brownell, Phil Carmody, Imre Deak, Hiroshi DOYU, Ari Kauppi,
> Tony Lindgren, Jarkko Nikula, Eero Nurkkala and Roman Tereshonkov.
>

Could you tell me how close TSC2005 is to TSC2007 (sans the different
interface - I2C vs SPI)?

Thanks.

-- 
Dmitry
