From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 5/5] input: wacom: Add a quirk for lowres Bamboo devices
Date: Fri, 03 Sep 2010 14:59:29 +0200
Message-ID: <4C80F131.2020004@euromail.se>
References: <1283516247-11624-1-git-send-email-rydberg@euromail.se> <1283516247-11624-6-git-send-email-rydberg@euromail.se> <6753EB6004AFF34FAA275742C104F952022BB10D@wacom-nt10.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:34231 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754Ab0ICNAK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Sep 2010 09:00:10 -0400
In-Reply-To: <6753EB6004AFF34FAA275742C104F952022BB10D@wacom-nt10.wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pingc@wacom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/03/2010 02:47 PM, Ping Cheng wrote:
[...]
> +	/* quirks for bamboo touch */

> +	if (features->x_max == 480 && features->y_max == 320) {
>  
> A check on all Bamboo touch devices can be a generic way to cover all
> Bamboos with touch feature (4 models). This check can be based on the
> product id or features->type (== BAMBOO_PT) in combination with the
> actual type (pen/touch) of the device.  All Bamboo touch devices use the
> same protocol.


I guess the only one who knows if there will be other resolutions reported for
BAMBOO_PT is you. :-) I wanted to not break any eventual resolution improvements
in the BAMBOO_PT family, but if you say there aren't any, using the BAMBOO_PT
check will be better, as you say.


> +		features->x_max = 15360;
> +		features->y_max = 10240;
> 
> I guess these two numbers rely on the original maxes: (480, 320). If so,
> can we also make them generic by accessing features->x_max/y_max
> directly?


If you mean something like "features->x_max <<= 5", absolutely. Again, this all
depends on what resolutions are to be anticipated, and which ones should be
scaled this way.

Henrik
