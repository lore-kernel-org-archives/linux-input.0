From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Fri, 12 Sep 2014 17:26:29 -0700
Message-ID: <20140913002629.GA12622@core.coreip.homeip.net>
References: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
 <1410512912-11609-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36139 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaIMA0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 20:26:34 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so2380895pad.30
        for <linux-input@vger.kernel.org>; Fri, 12 Sep 2014 17:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410512912-11609-4-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi Hans,

On Fri, Sep 12, 2014 at 11:08:32AM +0200, Hans de Goede wrote:
> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
> +		if (!set_properties || focaltech_init(psmouse) == 0) {
> +			/* Not supported yet, use bare protocol */
> +			psmouse_max_proto = PSMOUSE_PS2;

I do not believe we need to muck with psmouse_max_proto here, so I'll
drop it and apply.

Thanks.

> +			return PSMOUSE_PS2;
> +		}
> +	}
> +
>  /*
>   * We always check for lifebook because it does not disturb mouse
>   * (it only checks DMI information).
> -- 
> 2.1.0
> 

-- 
Dmitry
