From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] usbhid: call report_fixup before comparing descriptors
Date: Tue, 18 Sep 2012 16:00:16 +0400
Message-ID: <50586250.4060208@mvista.com>
References: <50578272.1020902@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50578272.1020902-ZgHIA9YJVL4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Daughtridge <kevin-ZgHIA9YJVL4@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello.

On 18-09-2012 0:05, Kevin Daughtridge wrote:

> hid_post_reset checks the stored report descriptor against what is currently
> returned by the device. An HID driver's report_fixup method may have changed the
> stored descriptor, however, creating false positives. These leave some devices
> nonfunctional after a resume, with a "reset_resume error 1" reported. This patch
> passes the new descriptor to the driver's report_fixup method, if any, before it
> is compared to the stored one.

> BugLink: http://bugs.launchpad.net/bugs/1049623
> Signed-off-by: Kevin Daughtridge <kevin-ZgHIA9YJVL4@public.gmane.org>
> ---
> --- a/drivers/hid/usbhid/hid-core.c    2012-08-20 10:17:09.000000000 -0700
> +++ b/drivers/hid/usbhid/hid-core.c    2012-09-16 18:51:45.381868737 -0700
> @@ -1436,6 +1436,10 @@ static int hid_post_reset(struct usb_int
>           kfree(rdesc);
>           return 1;
>       }
> +
> +    if (hid->driver && hid->driver->report_fixup)
> +        rdesc = hid->driver->report_fixup(hid, rdesc, &status);
> +

    Your patch is whitespace damaged, i.e. has all tabs replaced by spaces.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
