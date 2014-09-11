From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Thu, 11 Sep 2014 10:26:19 -0700
Message-ID: <20140911172619.GD13083@core.coreip.homeip.net>
References: <1410425447-9575-1-git-send-email-hdegoede@redhat.com>
 <1410425447-9575-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54158 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaIKR0Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 13:26:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so8334571pdb.14
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 10:26:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410425447-9575-3-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi Hans,

On Thu, Sep 11, 2014 at 10:50:47AM +0200, Hans de Goede wrote:
> @@ -722,6 +723,13 @@ static int psmouse_extensions(struct psmouse *psmouse,
>  {
>  	bool synaptics_hardware = false;
>  
> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
> +		/* Not supported yet, use bare protocol */
> +		psmouse_max_proto = max_proto = PSMOUSE_PS2;
> +		goto reset_to_defaults;

Why do we need to jump to a new label instead of simply saying

		return PSMOUSE_PS2;

> +	}
> +

Thanks.

-- 
Dmitry
