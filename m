From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v2] input: drv260x: Add TI drv260x haptics driver
Date: Mon, 28 Jul 2014 10:43:34 -0700
Message-ID: <20140728174334.GD8982@core.coreip.homeip.net>
References: <1406566403-1436-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406566403-1436-1-git-send-email-dmurphy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dan,

On Mon, Jul 28, 2014 at 11:53:23AM -0500, Dan Murphy wrote:
> Add the TI drv260x haptics/vibrator driver.
> This device uses the input force feedback
> to produce a wave form to driver an
> ERM or LRA actuator device.
> 
> The initial driver supports the devices
> real time playback mode.  But the device
> has additional wave patterns in ROM.

As it presented the device appears to be a memoryless device, however
you present it to the rest of the system as if it can support playback
of multiple effects simultaneously, which is incorrect.

My guess that you need to engage the memoryless input library to schedule
handling multiple effects for your device, including ramping up, ramping
down, stopping playback when effects runs out, etc.

Thanks.
 
-- 
Dmitry

P.S. If you are using devm_ there is devm_input_allocate_dveice().
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
