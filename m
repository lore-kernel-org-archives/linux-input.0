From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: roccat: Add support for Roccat Kone[+]
Date: Thu, 11 Nov 2010 01:00:16 -0800
Message-ID: <20101111090015.GG24415@core.coreip.homeip.net>
References: <1287943025.2623.16.camel@neuromancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287943025.2623.16.camel@neuromancer>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Stephane Chatty <chatty@enac.fr>, Don Prince <dhprince-devel@yahoo.co.uk>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stefan,

On Sun, Oct 24, 2010 at 07:57:05PM +0200, Stefan Achatz wrote:
> +
> +static int koneplus_create_sysfs_attributes(struct usb_interface *intf)
> +{
> +	int retval;
> +
> +	retval = sysfs_create_group(&intf->dev.kobj, &koneplus_attribute_group);
> +	if (retval)
> +		goto exit_1;
> +
> +	retval = sysfs_create_bin_file(&intf->dev.kobj,
> +			&koneplus_profile_settings_attr);
> +	if (retval)
> +		goto exit_2;
> +
> +	retval = sysfs_create_bin_file(&intf->dev.kobj,
> +			&koneplus_profile1_settings_attr);
> +	if (retval)
> +		goto exit_3;
> +

...

> +
> +	retval = sysfs_create_bin_file(&intf->dev.kobj,
> +			&koneplus_sensor_attr);
> +	if (retval)
> +		goto exit_17;
> +

I think we are ready to sysfs_binary_attribute_group ;) Please add it to
sysfs code and send it to GregKH.

Thanks.

-- 
Dmitry
