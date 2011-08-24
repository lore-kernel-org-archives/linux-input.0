From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2 7/7] Input: elantech - add v3 hardware support
Date: Wed, 24 Aug 2011 09:35:20 -0500
Message-ID: <20110824143520.GB23868@thinkpad-t410>
References: <1314164686-866-1-git-send-email-jj_ding@emc.com.tw>
 <1314164686-866-8-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314164686-866-8-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?utf-8?B?w4lyaWM=?= Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 24, 2011 at 01:44:46PM +0800, JJ Ding wrote:
> @@ -403,11 +503,39 @@ static int elantech_packet_check_v2(struct psmouse *psmouse)
>  }
>  
>  /*
> + * We check the constant bits to determine what packet type we get,
> + * so packet checking is mandatory for v3 hardware.
> + */
> +static int elantech_packet_check_v3(struct psmouse *psmouse)
> +{
> +	unsigned char *packet = psmouse->packet;
> +
> +	if ((packet[0] & 0x0c) == 0x04 &&
> +	    (packet[3] & 0xcf) == 0x02)
> +		return PACKET_V3_HEAD;
> +
> +	if ((packet[0] & 0x0c) == 0x0c &&
> +	    (packet[3] & 0xce) == 0x0c)
> +		return PACKET_V3_TAIL;
> +
> +	if (packet[0] == 0xc4 &&
> +	    packet[1] == 0xff &&
> +	    packet[2] == 0xff &&
> +	    packet[3] == 0x02 &&
> +	    packet[4] == 0xff &&
> +	    packet[5] == 0xff)
> +		return PACKET_DEBOUNCE;
> +
> +	return PACKET_UNKNOWN;
> +}

This will never return PACKET_DEBOUNCE, because those packets will have
already matched the conditions for PACKET_V3_HEAD. That condition needs
to be moved to the top of the function.

Seth
