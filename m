From: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Mon, 24 Nov 2014 16:56:56 -0800
Message-ID: <CANLzEkv5MM8sT3WsPyqYvn=H_MHkuuELsfZQfJtJA0dwzdruKg@mail.gmail.com>
References: <1415909806-23848-1-git-send-email-bleung@chromium.org>
	<1415956110.2640.5.camel@linux-0dmf.site>
	<CANLzEkvcm5g_T+FsEQF2UFzS5A2u7CWgdTiEJAxidfxgAE5bHw@mail.gmail.com>
	<1416820395.19925.4.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416820395.19925.4.camel-AfvqVibwNMkMNNZnWhT/Jw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sameer Nanda <snanda-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Oliver,

On Mon, Nov 24, 2014 at 1:13 AM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
>
> But there is very little to be gained by switching off remote wakeup.
> The additional energy consumption devices with remote wakeup enabled
> will be dwarfed by the energy needed for an additional wakeup.
>

That makes sense to me. Does this mean we should be moving toward a
solution that doesn't wake suspended devices on close for other usb
devices, not just hid?

This particular pattern of get()/needs_remote_wakeup=0/put() on
close() appears in several other drivers, for example :
62ecae0 Input: wacom - properly enable runtime PM
5d9efc5 Input: usbtouchscreen - implement runtime power management


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
