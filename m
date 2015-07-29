From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps
 protocol
Date: Wed, 29 Jul 2015 14:01:10 -0700
Message-ID: <20150729210110.GG23178@dtor-ws>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
 <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34297 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbG2VBP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 17:01:15 -0400
Received: by pdbbh15 with SMTP id bh15so11792122pdb.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2015 14:01:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438202726-5100-2-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Hans de Bruin <jmdebruin@xmsnet.nl>

On Wed, Jul 29, 2015 at 04:45:26PM -0400, cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
> 
> The data concerning which buttons on the touchpad are held down or not
> are in the fourth packet we receive from the mouse, not the first.
> 
> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>

Let's also make sure it hoes not break Hans' (de Bruin) touchpad.

> ---
>  drivers/input/mouse/alps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 113d6f1..e2f9b25 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
>  	/* Non interleaved V2 dualpoint has separate stick button bits */
>  	if (priv->proto_version == ALPS_PROTO_V2 &&
>  	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
> -		left |= packet[0] & 1;
> -		right |= packet[0] & 2;
> -		middle |= packet[0] & 4;
> +		left |= packet[3] & 1;
> +		right |= packet[3] & 2;
> +		middle |= packet[3] & 4;
>  	}
>  
>  	alps_report_buttons(dev, dev2, left, right, middle);
> -- 
> 2.4.3
> 

-- 
Dmitry
