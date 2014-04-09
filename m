From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] serio: Add pnp_id to struct serio
Date: Wed, 9 Apr 2014 11:06:52 -0700
Message-ID: <20140409180652.GA3060@core.coreip.homeip.net>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
 <1397052181-22768-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33519 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbaDISG6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 14:06:58 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2742547pdj.22
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 11:06:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397052181-22768-2-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi Hans,

On Wed, Apr 09, 2014 at 04:02:59PM +0200, Hans de Goede wrote:
> Serio device drivers need access to the pnp_id of the serio port, windows
> drivers bind by the pnp-id and some drivers need to know the exact pnp-id
> used so they know exactly with which hardware model / revision they are
> dealing with.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  include/linux/serio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index 9f779c7..6532440 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/pnp.h>
>  #include <uapi/linux/serio.h>
>  
>  struct serio {
> @@ -28,6 +29,7 @@ struct serio {
>  	bool manual_bind;
>  
>  	struct serio_device_id id;
> +	struct pnp_id *pnp_id;

Why do we need this if we are already adding generic 'firmware_id'
attribute?

Thanks.

-- 
Dmitry
