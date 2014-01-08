From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - cleanup rmi_i2c_probe()
Date: Wed, 8 Jan 2014 14:46:25 -0800
Message-ID: <20140108224625.GB27279@core.coreip.homeip.net>
References: <1389219092-32042-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56652 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbaAHWq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 17:46:29 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so2377153pdi.10
        for <linux-input@vger.kernel.org>; Wed, 08 Jan 2014 14:46:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389219092-32042-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed, Jan 08, 2014 at 02:11:32PM -0800, Christopher Heiny wrote:
> Moves i2c_check_functionality to occur before the gpio_config() call.  This 
> can catch some issues that would otherwise result in mysterious problems
> in gpio_config().
> 
> Reduces debugging output; updates remaining output to be more accurate.

What kind of gpio config is there? Did not we add proper configuration
of attn_gpio to the core? Do you really need these callbacks? They will
hurt you when you will try to move to devicetree-based setups.

Thanks.

-- 
Dmitry
