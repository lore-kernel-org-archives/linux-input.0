From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: Corrected mode of sysfs attr 'sensor' from
 koneplus driver
Date: Tue, 15 Mar 2011 15:41:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103151541540.19969@pobox.suse.cz>
References: <1300135387.7466.0.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53958 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543Ab1COOmA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 10:42:00 -0400
In-Reply-To: <1300135387.7466.0.camel@neuromancer>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 Mar 2011, Stefan Achatz wrote:

> Mode of sysfs attribute 'sensor' was wrongly set to writeonly.
> Corrected this to readwrite.
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
>  drivers/hid/hid-roccat-koneplus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
> index a8e2117..33eec74 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -460,7 +460,7 @@ static struct device_attribute koneplus_attributes[] = {
>  
>  static struct bin_attribute koneplus_bin_attributes[] = {
>  	{
> -		.attr = { .name = "sensor", .mode = 0220 },
> +		.attr = { .name = "sensor", .mode = 0660 },
>  		.size = sizeof(struct koneplus_sensor),
>  		.read = koneplus_sysfs_read_sensor,
>  		.write = koneplus_sysfs_write_sensor

Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
