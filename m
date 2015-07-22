From: "DusonLin" <dusonlin@emc.com.tw>
Subject: RE: [PATCH] Input - elantech: Add special check for fw_version 0x470f01  touchpad
Date: Thu, 23 Jul 2015 07:57:51 +0800
Message-ID: <000901d0c4da$3b0bd450$b1237cf0$@emc.com.tw>
References: <6967BE3D-14C4-47F1-B8D1-BA309D653150@emc.com.tw> <20150722195516.GA1854@lantern>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:56424 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGVX57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 19:57:59 -0400
In-Reply-To: <20150722195516.GA1854@lantern>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>

Hi,
I think it is different. It looks like the issue about these three laptops
are enabled CRC but can't use the sanity check for crc_enabled=1 case. So,
they need change to go to crc_enabled=0 case.

 * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
 * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
 * Fujitsu H730           0x570f00        c0, 14, 0c      3 hw buttons (**)

But the issue for 0x470f01 touchpad is the CRC doesn't enabled and the
sanity check for crc_enabled=0 case still can't satisfy the check.

BTW, yes, I can share the laptop information, I will upstream patch again.
Thanks for your advice.

Duson


-----Original Message-----
From: ulrik.debie-os@e2big.org [mailto:ulrik.debie-os@e2big.org] 
Sent: Thursday, July 23, 2015 3:55 AM
To: duson
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Dmitry
Torokhov
Subject: Re: [PATCH] Input - elantech: Add special check for fw_version
0x470f01 touchpad


On Wed, Jul 22, 2015 at 09:55:51PM +0800, duson wrote:
> 
> t is no need to check the packet[0] for sanity check when doing
> elantech_packet_check_v4() function for fw_version = 0x470f01 touchpad.
> 
Hi Duson,

The laptops below also had issues with crc_enabled and they were solved by
the elantech_dmi_force_crc_enabled table.
(0dc1587905a50f8f61bbc29e850aa592821e4bea)

 * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
 * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
 * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)

Does the 0x470f01 laptop maybe have exactly the same issue ? In that case,
would it not be better if we could harmonize the solution ?
Do you also have the laptop name, firmware version and button configuration
available for 0x470f01 and are you in a position to share that information ?
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |   25 ++++++++++++++++++++++---
>  drivers/input/mouse/elantech.h |    1 +
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c 
> b/drivers/input/mouse/elantech.c index ce3d400..d969153 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -784,6 +784,8 @@ static int elantech_packet_check_v4(struct psmouse
*psmouse)
>  	unsigned char *packet = psmouse->packet;
>  	unsigned char packet_type = packet[3] & 0x03;
>  	bool sanity_check;
> +	/* This represents the version of IC body. */
> +	int ver = (etd->fw_version & 0x0f0000) >> 16;
>  
>  	if (etd->tp_dev && (packet[3] & 0x0f) == 0x06)
>  		return PACKET_TRACKPOINT;
> @@ -796,9 +798,17 @@ static int elantech_packet_check_v4(struct psmouse
*psmouse)
>  	 */
>  	if (etd->crc_enabled)
>  		sanity_check = ((packet[3] & 0x08) == 0x00);
> -	else
> -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> -				(packet[3] & 0x1c) == 0x10);
> +	else {
> +		/* 
> +		 * The sanity check only need to check packet[3]
> +		 * when IC_body = 7 and PID = 0x2A  
> +		 */
> +		if (ver == 7 && etd->samples[1] == 0x2A)
> +			sanity_check = ((packet[3] & 0x1c) == 0x10);
> +		else
> +			sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> +					(packet[3] & 0x1c) == 0x10);
> +	}
>  
>  	if (!sanity_check)
>  		return PACKET_UNKNOWN;
> @@ -1648,6 +1658,15 @@ int elantech_init(struct psmouse *psmouse)
>  		     etd->capabilities[0], etd->capabilities[1],
>  		     etd->capabilities[2]);
>  
> +	if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY,
> +	    etd->samples)) {
> +		psmouse_err(psmouse, "failed to query sample data.\n");
> +		goto init_fail;
> +	}
> +	psmouse_info(psmouse,
> +		     "Elan sample query result 0x%02x, 0x%02x, 0x%02x.\n",
> +		     etd->samples[0], etd->samples[1], etd->samples[2]);
> +

Is this wise to run on all elantech hardware ?

>  	if (elantech_set_absolute_mode(psmouse)) {
>  		psmouse_err(psmouse,
>  			    "failed to put touchpad into absolute mode.\n");
diff --git 
> a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h 
> index f965d15..e1cbf40 100644
> --- a/drivers/input/mouse/elantech.h
> +++ b/drivers/input/mouse/elantech.h
> @@ -129,6 +129,7 @@ struct elantech_data {
>  	unsigned char reg_26;
>  	unsigned char debug;
>  	unsigned char capabilities[3];
> +	unsigned char samples[3];
>  	bool paritycheck;
>  	bool jumpy_cursor;
>  	bool reports_pressure;
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

Kind regards,
Ulrik


