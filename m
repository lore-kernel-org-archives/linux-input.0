From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 09/17] Input: tsc2005 - rework driver initialization
 code
Date: Wed, 16 Mar 2011 17:11:48 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161703570.2634@esdhcp041196.research.nokia.com>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv> <20110316071846.25664.36864.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:24349 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab1CPPOY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 11:14:24 -0400
In-Reply-To: <20110316071846.25664.36864.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi,

> -	r = input_register_device(ts->idev);
> -	if (r) {
> -		dev_err(&ts->spi->dev, "input_register_device(): %d\n", r);
> -		goto err2;
> +	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!ts || !input_dev) {
> +		error = -ENOMEM;
> +		goto err_free_mem;
> 	}

ts->idev is never initialized, so input_register_device() will crash.

A.
