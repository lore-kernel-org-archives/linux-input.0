From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] intel_mid: Keypad Driver (Current snapshot for reference)
Date: Wed, 9 Feb 2011 10:49:13 -0800
Message-ID: <20110209184913.GD23867@core.coreip.homeip.net>
References: <20110209095151.32388.66409.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55756 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1BIS4J (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 13:56:09 -0500
Received: by gxk9 with SMTP id 9so223937gxk.19
        for <linux-input@vger.kernel.org>; Wed, 09 Feb 2011 10:56:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110209095151.32388.66409.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Wed, Feb 09, 2011 at 09:53:04AM +0000, Alan Cox wrote:
> +
> +	/* Check with the firmware if the keypad is enabled */
> +	if (!mrst_keypad_enabled())
> +		return 0;
> +

-ENXIO;

-- 
Dmitry
