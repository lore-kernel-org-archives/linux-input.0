From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: Made tcu sysfs attr rw to allow readout of
 koneplus sensor register data
Date: Wed, 17 Oct 2012 17:38:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210171738140.26584@pobox.suse.cz>
References: <1350484542.12102.2.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51250 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab2JQPij (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 11:38:39 -0400
In-Reply-To: <1350484542.12102.2.camel@neuromancer.tessier-ashpool>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 17 Oct 2012, Stefan Achatz wrote:

> tcu sysfs attr was used to only control calibration process so far. Reverse
> engineering the firmware revealed direct sensor register access. Allowing
> readout of tcu permits usage of this feature.
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
>  .../ABI/testing/sysfs-driver-hid-roccat-koneplus   |    6 +++---
>  drivers/hid/hid-roccat-koneplus.c                  |   11 ++++++++++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus b/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
> index 65e6e5d..f9e2a61 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
> @@ -104,9 +104,9 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-
>  Date:		October 2010
>  Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
>  Description:	When written a calibration process for the tracking control unit
> -		can be initiated/cancelled.
> -		The data has to be 3 bytes long.
> -		This file is writeonly.
> +		can be initiated/cancelled. Also lets one read/write sensor
> +		registers.
> +		The data has to be 4 bytes long.
>  Users:		http://roccat.sourceforge.net
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/tcu_image
> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
> index f5602fe..c47540a 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -222,6 +222,14 @@ static ssize_t koneplus_sysfs_write_tcu(struct file *fp,
>  			sizeof(struct koneplus_tcu), KONEPLUS_COMMAND_TCU);
>  }
>  
> +static ssize_t koneplus_sysfs_read_tcu(struct file *fp,
> +		struct kobject *kobj, struct bin_attribute *attr, char *buf,
> +		loff_t off, size_t count)
> +{
> +	return koneplus_sysfs_read(fp, kobj, buf, off, count,
> +			sizeof(struct koneplus_tcu), KONEPLUS_COMMAND_TCU);
> +}
> +
>  static ssize_t koneplus_sysfs_read_tcu_image(struct file *fp,
>  		struct kobject *kobj, struct bin_attribute *attr, char *buf,
>  		loff_t off, size_t count)
> @@ -426,8 +434,9 @@ static struct bin_attribute koneplus_bin_attributes[] = {
>  		.write = koneplus_sysfs_write_sensor
>  	},
>  	{
> -		.attr = { .name = "tcu", .mode = 0220 },
> +		.attr = { .name = "tcu", .mode = 0660 },
>  		.size = sizeof(struct koneplus_tcu),
> +		.read = koneplus_sysfs_read_tcu,
>  		.write = koneplus_sysfs_write_tcu
>  	},
>  	{

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
