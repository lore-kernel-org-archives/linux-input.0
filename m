From: "DusonLin" <dusonlin@emc.com.tw>
Subject: RE: [PATCH 2/2] Input - elantech: Add special check for fw_version 0x470f01 touchpad
Date: Sun, 2 Aug 2015 11:18:31 +0800
Message-ID: <000301d0ccd1$ec2ae650$c480b2f0$@emc.com.tw>
References: <93F83051-8AD8-41EA-9A43-CB1D32DA09E9@emc.com.tw> <20150728191855.GA19870@lantern>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150728191855.GA19870@lantern>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

Sorry for later reply,
I am not sure version 1 is ok or not, so, I think I should modify my patch
and let ETP_SAMPLE_QUERY only work for version 2,3,4.
And for your question, yes, I think you can use "etd->samples" at
elantech_set_range for version 2, even though the definition of these three
bytes 
maybe different between version 2 and 3.

Thank you,
Duson

-----Original Message-----
From: ulrik.debie-os@e2big.org [mailto:ulrik.debie-os@e2big.org] 
Sent: Wednesday, July 29, 2015 3:19 AM
To: duson
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Dmitry
Torokhov
Subject: Re: [PATCH 2/2] Input - elantech: Add special check for fw_version
0x470f01 touchpad


Hi Duson,

Thanks for your update.

Your latest patch has 2 trailing whitespaces problems as shown by
checkpatch.pl.

There was another comment you probably overlooked in my previous mail:
> +	if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY,
> +	    etd->samples)) {

Is this wise to run on all elantech hardware ? No regression ?
Currently it is called when hw_version = 2 and some other conditions in the
function elantech_set_range. That could be a hint that the range hw_version
2->7 is probably ok, but what about hw_version 1 ? 

Is it normal that the semantics of ETP_SAMPLE_QUERY on hw_version 2 is
totally different from the fw_version 0x470f01 ?

Assuming there are no regressions introduced by ETP_SAMPLE_QUERY, I would
change elantech_set_range to use the stored sample values instead of
querying for it again. That probably can be put in a separate patch.

Thanks,
Kind Regards,
Ulrik

On Thu, Jul 23, 2015 at 08:54:32AM +0800, duson wrote:
> 
> It is no need to check the packet[0] for sanity check when doing
> elantech_packet_check_v4() function for fw_version = 0x470f01 touchpad.
> 
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |   26 +++++++++++++++++++++++---
>  drivers/input/mouse/elantech.h |    1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c 
> b/drivers/input/mouse/elantech.c index ce3d400..6c6c2bb 100644
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
> @@ -1117,6 +1127,7 @@ static int elantech_get_resolution_v4(struct psmouse
*psmouse,
>   * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
>   * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
>   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons
(**)
> + * Fujitsu T725	           0x470f01        05, 12, 09      2 hw
buttons
>   * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
>   * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons
(*)
>   * Lenovo L530             0x350f02        b9, 15, 0c      2 hw buttons
(*)
> @@ -1648,6 +1659,15 @@ int elantech_init(struct psmouse *psmouse)
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
