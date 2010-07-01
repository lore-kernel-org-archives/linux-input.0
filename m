From: Xiaofan Chen <xiaofanc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Thu, 1 Jul 2010 10:40:11 +0800
Message-ID: <AANLkTinwLs0LBv3PSkJpCggNDbXDZ5dwqqe_vwSxgP-Z@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 1, 2010 at 12:40 AM, Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> (4)
>
> Regarding libusb / libhid usage ,
> the usb device i am using is a composite device
> having hid and audio interfaces .
>
> is it possible to claim audio interface from kernel space
> and hid interface from user space ?
>

Sure. You just need to detach the hid interface
from the kernel driver.
All in all, I think you will be better off using libusb
or libusb for what you want to achieve.



-- 
Xiaofan http://sourceforge.net/projects/libusb-win32/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
