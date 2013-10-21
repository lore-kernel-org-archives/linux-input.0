From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Mon, 21 Oct 2013 08:59:27 -0700
Message-ID: <20131021155927.GB4255@core.coreip.homeip.net>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55921 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3JUP7a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 11:59:30 -0400
Content-Disposition: inline
In-Reply-To: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-input@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

Hi Denis,

On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
>  
> +	if (ts->of)
> +		return tsc2007_get_pendown_state_dt(ts);
> +
>  	if (!ts->get_pendown_state)
>  		return true;

Instead of special casing "if (ts->of)" all over the place why don't you
set up the device structure as:

	if (<configuring_tsc2007_form_dt>)
		ts->get_pendown_state = tsc2007_get_pendown_state_dt;

and be done with it?

Thanks.

-- 
Dmitry
