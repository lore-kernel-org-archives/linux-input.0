From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Thu, 3 Jul 2008 13:27:00 -0400
Message-ID: <20080703132305.ZZRA012@mailhub.coreip.homeip.net>
References: <20080703164235.37739A006B@mail196-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:14828 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYGCR1F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jul 2008 13:27:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so513569pyb.10
        for <linux-input@vger.kernel.org>; Thu, 03 Jul 2008 10:27:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080703164235.37739A006B@mail196-wa4.bigfish.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk, Sadanand <sadanan@xilinx.com>

Hi John,

On Thu, Jul 03, 2008 at 09:42:31AM -0700, John Linn wrote:
> +
> +	/* Initialize the PS/2 interface */
> +	mutex_lock(&drvdata->cfg_mutex);
> +	if (xps2_initialize(drvdata)) {
> +		mutex_unlock(&drvdata->cfg_mutex);
> +		dev_err(dev, "Could not initialize device\n");
> +		retval = -ENODEV;
> +		goto failed3;
> +	}
> +	mutex_unlock(&drvdata->cfg_mutex);

The drvdata is allocated per-port and so both (there are 2 PS/2 ports,
right?) ports get their own copy of cfg_mutex. Since you are trying to
serialze access to resource shared by both ports it will not work.
The original driver-global mutex was appropriate (the only thing I
objected there was use of a counting semaphore instead of a mutex).

-- 
Dmitry
