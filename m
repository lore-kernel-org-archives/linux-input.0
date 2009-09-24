From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Thu, 24 Sep 2009 11:13:46 -0600
Message-ID: <4ABBA8CA.8030303@ridgerun.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:45838 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbZIXRNq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 13:13:46 -0400
In-Reply-To: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org
Cc: nsnehaprabha@ti.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Dmitry,

> +				keycode = keymap[i];
> +				release = (new_status >> i) & 0x1;
> +				dev_info(dev, "davinci_keyscan: key %d %s\n",
> +				    keycode, release ? "released" : "pressed");

I did a little mistake here I used dev_info instead of dev_dbg, let me know if 
there is any other comment before I send a patch fixed.

Thanks,

Miguel Aguilar
