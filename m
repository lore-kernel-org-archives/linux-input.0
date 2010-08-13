From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Dual touchscreen implementation
Date: Fri, 13 Aug 2010 00:50:48 -0700
Message-ID: <20100813075047.GA7700@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35736 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0HMHux (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 03:50:53 -0400
Received: by pxi10 with SMTP id 10so718395pxi.19
        for <linux-input@vger.kernel.org>; Fri, 13 Aug 2010 00:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Tue, Aug 10, 2010 at 06:16:27PM -0500, Arce, Abraham wrote:
> Hi,
> 
> I am working in a board with dual display/touchscreen. I have searched within drivers/input/touchscreen for some examples on how to implement the functionality to configure driver and behave as a single touchscreen if 2 sensors are present, no specific example found
> 
> My idea is to create an attribute "virtualized" to enable/disable virtualization in the second touchscreen
> 
> + static DEVICE_ATTR(virtualized, S_IRUGO | S_IWUSR,
> + 		   syn_show_attr_virtualized, syn_store_attr_virtualized);
> 
> 
> In the function which reports the values to input subsystem we can then decide to make the second one as an extension of the first touchscreen if
> 
> * virtualized is set to 1
> * and touchscreen sensor is the second one
> 
> 
>  + if (ts->virtualized && dev_name(&sensor->dev == '2')
>  +	data->x = ts->touch_caps.max_x + d->x;
>  [..]
>  + input_report_abs(idev, ABS_x, data->x);
> 
> 
> I'd appreciate any comments on this approach...
> 

Does the kernel have to do that? I'd say it is userspace task to
[re]interpret events.

-- 
Dmitry
