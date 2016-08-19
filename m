From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Fix register descriptor subpacket
 map construction
Date: Fri, 19 Aug 2016 09:45:08 +0200
Message-ID: <20160819074508.GW17850@mail.corp.redhat.com>
References: <1471547133-26819-1-git-send-email-andrew@duggan.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbcHSHpO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 03:45:14 -0400
Content-Disposition: inline
In-Reply-To: <1471547133-26819-1-git-send-email-andrew@duggan.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <andrew@duggan.us>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Nitin Chaudhary <nitinchaudhary1289@gmail.com>, stable@vger.kernel.org

Hi Andrew,

On Aug 18 2016 or thereabouts, Andrew Duggan wrote:
> From: Andrew Duggan <aduggan@synaptics.com>
> 
> The map_offset variable is specific to the register and needs to be reset
> in the loop. Otherwise, subsequent register's subpacket maps will have
> their bits set at the wrong index. This results in the max X and Y and
> the resolution to not be set on some devices which use F12.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Tested-by: Nitin Chaudhary <nitinchaudhary1289@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> In rmi_f12_read_sensor_tuning() we call rmi_register_desc_has_subpacket()
> to check the subpacket map to make sure a subpacket exists to ensure that
> the buffer contains the correct data. It happened that on my the test
> devices the register we were checking was also the first register. This
> issues showed up on newer devices where F12 CTRL 8 is not teh first control
> register.

I just have one minor nitpick:

> 
> Thanks,
> Andrew
> 
>  drivers/input/rmi4/rmi_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 2b6b97e..19843f1 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -553,10 +553,10 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
>  		goto free_struct_buff;
>  
>  	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
> -	map_offset = 0;
>  	for (i = 0; i < rdesc->num_registers; i++) {
>  		struct rmi_register_desc_item *item = &rdesc->registers[i];
>  		int reg_size = struct_buf[offset];

There should be a blank line here (coding style).

> +		map_offset = 0;

I'd rather see this reset just before the do/while loop given that it's
IMO clearer what is happening.

Anyway:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  
>  		++offset;
>  		if (reg_size == 0) {
> -- 
> 2.7.4
> 
