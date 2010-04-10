From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 21:25:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004102123210.8345@pobox.suse.cz>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45139 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab0DJTZo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 15:25:44 -0400
In-Reply-To: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux@philmerk.de, chatty@enac.fr

On Sat, 10 Apr 2010, Stephane Chatty wrote:

> Added support for the eGalax dual-touch panel, found on the Asus EeePC 
> T101MT

Thanks a lot for the driver!

> +	case HID_UP_DIGITIZER:
> +		switch (usage->hid) {
> +		case HID_DG_TIPSWITCH:
> +			/* touchscreen emulation */
> +			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +			return 1;
> +		case HID_DG_INRANGE:
> +		case HID_DG_CONFIDENCE:
> +		case HID_DG_CONTACTCOUNT:
> +		case HID_DG_CONTACTMAX:
> +			return -1;
> +		case HID_DG_CONTACTID:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_TRACKING_ID);
> +			return 1;
> +		case HID_DG_TIPPRESSURE:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_PRESSURE);
> +			return 1;
> +		}
> +		return 0;
> +	}
> +
> +	/* ignore others (from other reports we won't get anyway) */

>From other reports we won't get what anyway?

Otherwise the driver looks OK to me, I'll add the slab.h include as 
noticed by Christoph (as implicit slab.h inclusion has gone away in 
mainline already).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
