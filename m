From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/3] input: pwm-beeper: add feature to set volume level
Date: Thu, 19 Jan 2017 13:37:00 -0800
Message-ID: <20170119213700.GC13542@dtor-ws>
References: <0e2dec4d-7550-9495-f12a-020391183304@exceet.de>
 <cover.1484838551.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33065 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbdASVod (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 16:44:33 -0500
Content-Disposition: inline
In-Reply-To: <cover.1484838551.git.frieder.schrempf@exceet.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Cc: robh@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>

On Thu, Jan 19, 2017 at 04:24:07PM +0100, Frieder Schrempf wrote:
> Make the driver accept switching volume levels via sysfs.
> This can be helpful if the beep/bell sound intensity needs
> to be adapted to the environment of the device.
> 
> The number of volume levels available and their values can
> be specified via device tree (similar to pwm-backlight).
> 
> The volume adjustment is done by changing the duty cycle of
> the pwm signal.

I wonder how this all will mesh up with beepers that have dedicated
amplifiers (support is being added by David Lechner).

Thanks.

-- 
Dmitry
