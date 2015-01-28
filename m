From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] Make sure touch arbitration is applied consistently
 across devices
Date: Wed, 28 Jan 2015 14:31:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501281430480.6510@pobox.suse.cz>
References: <1422394151-15067-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbbA2BYD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2015 20:24:03 -0500
In-Reply-To: <1422394151-15067-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, 27 Jan 2015, Ping Cheng wrote:

> Signed-off-by: Ping Cheng <pingc@wacom.com>

Ping, please supply a changelog explaining even a simple and "obvious" 
changes (which actually is not even the case here).

Thanks.

> ---
>  drivers/hid/wacom_wac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index f886149..6d490f6 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1042,7 +1042,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>  
>  	for (i = 0; i < contacts_to_send; i++) {
>  		int offset = (WACOM_BYTES_PER_24HDT_PACKET * i) + 1;
> -		bool touch = data[offset] & 0x1 && !wacom->shared->stylus_in_proximity;
> +		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
>  		int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
>  
>  		if (slot < 0)
> @@ -1072,6 +1072,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>  	if (wacom->num_contacts_left <= 0)
>  		wacom->num_contacts_left = 0;
>  
> +	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
>  	return 1;
>  }
>  
> @@ -1100,7 +1101,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>  
>  	for (i = 0; i < contacts_to_send; i++) {
>  		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
> -		bool touch = data[offset] & 0x1;
> +		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
>  		int id = get_unaligned_le16(&data[offset + 1]);
>  		int slot = input_mt_get_slot_by_key(input, id);
>  
> @@ -1122,6 +1123,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>  	if (wacom->num_contacts_left < 0)
>  		wacom->num_contacts_left = 0;
>  
> +	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
>  	return 1;
>  }

-- 
Jiri Kosina
SUSE Labs
