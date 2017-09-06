From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: add multi-input quirk for IDC6680 touchscreen
Date: Wed, 6 Sep 2017 10:51:22 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061049310.4077@jbgna.fhfr.qr>
References: <20170904194042.16053-1-nbishop@neverware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170904194042.16053-1-nbishop-QeEie8R3kYhl57MIdRCFDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Bishop <nbishop-QeEie8R3kYhl57MIdRCFDg@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 4 Sep 2017, Nicholas Bishop wrote:

> The Ideacom 6680 touchscreen is found in the Dell Latitude 2100. It
> has two USB descriptors, the first of which has two input reports. The
> HID_QUIRK_MULTI_INPUT quirk is needed to keep the correct maximum
> value for ABS_X/ABS_Y (8191 instead of 65535).
> 
> For reference, here are the full reports:

I am all for verbose changelogs, but including the rdesc dump is probably 
a little bit too much :) So I've striped that and applied to 
for-4.14/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
