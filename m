From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: elantech - use elantech_report_trackpoint for
 hardware v4 too
Date: Sat, 8 Nov 2014 00:21:36 -0800
Message-ID: <20141108082136.GA21475@dtor-ws>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33122 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbaKHIVl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 03:21:41 -0500
Received: by mail-ig0-f179.google.com with SMTP id r10so6675272igi.12
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 00:21:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Aug 30, 2014 at 04:10:42PM +0200, Ulrik De Bie wrote:
> The Fujitsu H730 has hardware v4 with a trackpoint. This enables
> the elantech_report_trackpoint for v4.
> 
> Reported-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index da51738..f0a55b4d 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -792,6 +792,9 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
>  	unsigned char packet_type = packet[3] & 0x03;
>  	bool sanity_check;
>  
> +	if ((packet[3]&0x0f) == 0x06)
> +		return PACKET_TRACKPOINT;
> +
>  	/*
>  	 * Sanity check based on the constant bits of a packet.
>  	 * The constant bits change depending on the value of
> @@ -877,10 +880,19 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
>  
>  	case 4:
>  		packet_type = elantech_packet_check_v4(psmouse);
> -		if (packet_type == PACKET_UNKNOWN)
> +		switch (packet_type) {
> +		case PACKET_UNKNOWN:
>  			return PSMOUSE_BAD_DATA;
>  
> -		elantech_report_absolute_v4(psmouse, packet_type);
> +		case PACKET_TRACKPOINT:
> +			elantech_report_trackpoint(psmouse, packet_type);
> +			break;
> +
> +		default:
> +			elantech_report_absolute_v4(psmouse, packet_type);
> +			break;
> +		}
> +
>  		break;
>  	}
>  
> -- 
> 2.1.0
> 

-- 
Dmitry
