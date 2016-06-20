From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: RE: [PATCH] HID: fix noderef.cocci warnings
Date: Mon, 20 Jun 2016 12:40:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606201238540.6874@cbobk.fhfr.pm>
References: <201606182012.7NLmbFhz%fengguang.wu@intel.com> <20160618121314.GA95633@lkp-ib04> <OSXPR01MB0408C44F44A1B06579D0BCB7C72A0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OSXPR01MB0408C44F44A1B06579D0BCB7C72A0-x3s0nd+sA3ZOfzQfux4QuHcolHNk5qUtvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masaki Ota <masaki.ota-Ej8lA1M1qLxBDgjK7y7TUQ@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 20 Jun 2016, Masaki Ota wrote:

> Hi, fengguang,
> 
> 	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
> -			sizeof(input), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +			sizeof(*input), HID_FEATURE_REPORT,
> +			HID_REQ_SET_REPORT);

This is a wrong fix. sizeof(*input) is sizeof(u8).

> I tested this code, but our device cannot work on it.
> So, I think we should modify the code as below.
> 
> 	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
> 			sizeof(u8)*U1_FEATURE_REPORT_LEN,
> 			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);

I've already applied patch that fixes this (an one more callsite with the 
same issue); I CCed you on the patch earlier today.

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
