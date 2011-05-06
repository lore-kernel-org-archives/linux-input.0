From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Fri, 6 May 2011 08:52:04 -0700
Message-ID: <20110506155204.GA4754@core.coreip.homeip.net>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61207 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab1EFPwN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2011 11:52:13 -0400
Received: by pwi15 with SMTP id 15so1482517pwi.19
        for <linux-input@vger.kernel.org>; Fri, 06 May 2011 08:52:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Cc: linux-input@vger.kernel.org

Hi Eduard,

On Sat, Apr 09, 2011 at 12:54:14AM +0200, Eduard Hasenleithner wrote:
> This commit enables control of the LEDs and OLED displays found
> on the Wacom Intuos4 M, L, and XL. For this purpose, a new "led"
> attribute group is added to the sysfs entry of the input device.
> 
> This "led" group only shows up when the correct device (M, L,
> or XL) is detected. Four write-only attributes are created:
> * "luminance":
> 	array of three integers specfying
> 	* status led brightness when no button is pressed (0..127)
> 	* status led brightness when a button is pressed (0..127)
> 	* brightness of the OLED display (0..15)

This violates "one value per attribute" sysfs principle. I think these
should be split into brightness on, brightness off, and display brightness.
I also wonder if status LED should be wired into LED subsystem... Not
sure though... The tablet does not allow controlling when LEDs are
activated, does it?

> * "status_select":
> 	specifies the id (0..3) of the status led, -1 = none

I think we should create 4 separate groups led0 .. led3 each containing
the attributes above instead of implementing the selector which is
inherently racy.

> * "button_select":
> 	specifies the button id (0..7) of the image
> * "button_rawimg":
> 	sets the raw image data of the button (binary, 1024 octets)

Same here, create as many binary attributes as needed (probably putting
into separate group).

Also please document these attributes in
Documentation/ABI/testing/sysfs-wacom

Thanks!

-- 
Dmitry
