From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend 2/2] input/serio/8042: Add firmware_id support
Date: Wed, 9 Apr 2014 11:24:34 -0700
Message-ID: <20140409182434.GA25308@core.coreip.homeip.net>
References: <1397033270-29597-1-git-send-email-hdegoede@redhat.com>
 <1397033270-29597-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55737 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143AbaDISYj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 14:24:39 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so2781377pde.15
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 11:24:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397033270-29597-3-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Wed, Apr 09, 2014 at 10:47:50AM +0200, Hans de Goede wrote:
> Fill in the new serio firmware_id sysfs attribute for pnp instantiated
> 8042 serio ports.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 26 ++++++++++++++++++++++++++
>  drivers/input/serio/i8042.c           |  6 ++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 0ec9abb..3f9da83 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -704,6 +704,8 @@ static char i8042_pnp_aux_name[32];
>  
>  static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
>  {
> +	struct pnp_id *id = dev->id;
> +
>  	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
>  		i8042_pnp_data_reg = pnp_port_start(dev,0);
>  
> @@ -719,6 +721,17 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
>  		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
>  	}
>  
> +	if (id) {
> +		strlcpy(i8042_kbd_firmware_id, id->id,
> +			sizeof(i8042_kbd_firmware_id));
> +		for (id = id->next; id; id = id->next) {
> +			strlcat(i8042_kbd_firmware_id, " ",
> +				sizeof(i8042_kbd_firmware_id));
> +			strlcat(i8042_kbd_firmware_id, id->id,
> +				sizeof(i8042_kbd_firmware_id));

Do we need all IDs? I'd expect we only interested in HID, not CIDs?

Thanks.

-- 
Dmitry
