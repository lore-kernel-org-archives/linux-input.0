From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] elantech: fix for newer hardware versions (v7)
Date: Sat, 6 Jul 2013 21:59:23 -0700
Message-ID: <20130707045923.GB32745@core.coreip.homeip.net>
References: <51D7C6E6.8010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39214 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3GGE70 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jul 2013 00:59:26 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so3046372pdi.2
        for <linux-input@vger.kernel.org>; Sat, 06 Jul 2013 21:59:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D7C6E6.8010904@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo Delfino <kendatsuba@gmail.com>
Cc: linux-input@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>

On Sat, Jul 06, 2013 at 09:27:34AM +0200, Matteo Delfino wrote:
> * Fix version recognition in elantech_set_properties
> 
>   The new hardware reports itself as v7 but the packets'
>   structure is unaltered.
> 
> * Fix packet type recognition in elantech_packet_check_v4
> 
>   The bitmask used for v6 is too wide, only the last three bits of
>   the third byte in a packet (packet[3] & 0x03) are actually used to
>   distinguish between packet types.
>   Starting from v7, additional information (to be interpreted) is
>   stored in the remaining bits (packets[3] & 0x1c).
>   In addition, the value stored in (packet[0] & 0x0c) is no longer
>   a constant but contains additional information yet to be deciphered.
>   This change should be backwards compatible with v6 hardware.
> 
> Additional-author: Giovanni Frigione <gio.frigione@gmail.com>
> Signed-off-by: Matteo Delfino <kendatsuba@gmail.com>


Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index e2a9867..1c792c9 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -677,18 +677,18 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
>  static int elantech_packet_check_v4(struct psmouse *psmouse)
>  {
>  	unsigned char *packet = psmouse->packet;
> +	unsigned char packet_type = packet[3] & 0x03;
> 
> -	if ((packet[0] & 0x0c) == 0x04 &&
> -	    (packet[3] & 0x1f) == 0x11)
> +	switch (packet_type) {
> +	case 0:
> +		return PACKET_V4_STATUS;
> +
> +	case 1:
>  		return PACKET_V4_HEAD;
> 
> -	if ((packet[0] & 0x0c) == 0x04 &&
> -	    (packet[3] & 0x1f) == 0x12)
> +	case 2:
>  		return PACKET_V4_MOTION;
> -
> -	if ((packet[0] & 0x0c) == 0x04 &&
> -	    (packet[3] & 0x1f) == 0x10)
> -		return PACKET_V4_STATUS;
> +	}
> 
>  	return PACKET_UNKNOWN;
>  }
> @@ -1226,6 +1226,7 @@ static int elantech_set_properties(struct elantech_data *etd)
>  			etd->hw_version = 3;
>  			break;
>  		case 6:
> +		case 7:
>  			etd->hw_version = 4;
>  			break;
>  		default:
> -- 
> 1.7.10.4

-- 
Dmitry
