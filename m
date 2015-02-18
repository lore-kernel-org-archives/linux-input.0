From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] psmouse: Skip psmouse_initialize for FocalTech
 touchpads.
Date: Wed, 18 Feb 2015 11:55:37 -0800
Message-ID: <20150218195537.GA13997@dtor-glaptop>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1423940502-12353-3-git-send-email-mgottschlag@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44159 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbBRTzo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 14:55:44 -0500
Received: by padet14 with SMTP id et14so3555412pad.11
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2015 11:55:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423940502-12353-3-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi Mathias,

On Sat, Feb 14, 2015 at 08:01:41PM +0100, Mathias Gottschlag wrote:
>  /*
> @@ -1157,7 +1159,7 @@ static void psmouse_initialize(struct psmouse *psmouse)
>   * We set the mouse report rate, resolution and scaling.
>   */
>  
> -	if (psmouse_max_proto != PSMOUSE_PS2) {
> +	if (psmouse_max_proto != PSMOUSE_PS2 && !psmouse->skip_standard_init) {
>  		psmouse->set_rate(psmouse, psmouse->rate);
>  		psmouse->set_resolution(psmouse, psmouse->resolution);
>  		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);

Instead of introducing the new skip_standard_init flag can you instead define a
pointer for set_scale implementation and provide a dummy stub for it in
focatech, the same as you do for set_rate() and set_resoluton() in patch 3?

Thanks.

-- 
Dmitry
