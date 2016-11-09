From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: ALPS - Fix TrackStick support for SS5
 hardware
Date: Wed, 9 Nov 2016 13:12:31 +0100
Message-ID: <20161109121231.GB19557@pali>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbcKIMMf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Nov 2016 07:12:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id c17so28752202wmc.3
        for <linux-input@vger.kernel.org>; Wed, 09 Nov 2016 04:12:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161108151430.GN2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Tuesday 08 November 2016 10:14:30 Paul Donohue wrote:
> The current Alps SS5 (SS4 v2) code generates bogus TouchPad events when
> TrackStick packets are processed.
>     
> This causes the xorg synaptics driver to print
> "unable to find touch point 0" and
> "BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'"
> messages.  It also causes unexpected TouchPad button release and reclick
> event sequences if the TrackStick is moved while holding a TouchPad
> button.
>     
> This commit corrects the problem by adjusting
> alps_process_packet_ss4_v2() so that it only sends TrackStick reports
> when processing TrackStick packets.
> 
> Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 6d7de9b..b93fe83 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1346,6 +1346,18 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
>  
>  	priv->multi_packet = 0;
>  
> +	/* Report trackstick */
> +	if (alps_get_pkt_id_ss4_v2(packet) == SS4_PACKET_ID_STICK) {

I would propose to show warning when trackstick packet is received on
device marked as non-trackstick. It would help to debug possible
problems in future...

if (!(priv->flags & ALPS_DUALPOINT))
        psmouse_warn(psmouse, "Rejected trackstick packet from non DualPoint device");

> +		if (priv->flags & ALPS_DUALPOINT) {
> +			input_report_key(dev2, BTN_LEFT, f->ts_left);
> +			input_report_key(dev2, BTN_RIGHT, f->ts_right);
> +			input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
> +			input_sync(dev2);
> +		}
> +		return;
> +	}

-- 
Pali Rohár
pali.rohar@gmail.com
