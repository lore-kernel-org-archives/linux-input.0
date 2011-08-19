From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/9 v4] Input: synaptics - add image sensor support
Date: Fri, 19 Aug 2011 15:22:03 -0700
Message-ID: <20110819222203.GC5146@core.coreip.homeip.net>
References: <1313666888-18939-1-git-send-email-djkurtz@chromium.org>
 <1313666888-18939-5-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64088 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab1HSWWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 18:22:11 -0400
Content-Disposition: inline
In-Reply-To: <1313666888-18939-5-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: chase.douglas@canonical.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

Hi Daniel,

On Thu, Aug 18, 2011 at 07:28:03PM +0800, Daniel Kurtz wrote:
> @@ -558,6 +626,11 @@ static void synaptics_process_packet(struct psmouse *psmouse)
>  	if (synaptics_parse_hw_state(psmouse->packet, priv, &hw))
>  		return;
>  
> +	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
> +		synaptics_image_sensor_process(psmouse, &hw);
> +		return;
> +	}
> +

So what about the rest of the SYnaptics processing (wheel, additional
buttons, etc)?  Are we sure that touchpads with image sensors will never
implement them?
 
-- 
Dmitry
