From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Fri, 13 Nov 2009 06:34:26 +0100
Message-ID: <1258090466.3299.6.camel@violet>
References: <1252603292-20830-1-git-send-email-mjg@redhat.com>
	 <20090911051259.GC23210@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090911051259.GC23210-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Matthew,

> > Most laptops have keys that are intended to toggle all device state, not
> > just wifi. These are currently generally mapped to KEY_WLAN. As a result,
> > rfkill will only kill or enable wifi in response to the key press. This
> > confuses users and can make it difficult for them to enable bluetooth
> > and wwan devices.
> > 
> > This patch adds a new keycode, KEY_RFKILL_ALL. It indicates that the
> 
> The new name in description does not match the code...
> 
> > system should toggle the state of all rfkillable devices.
> 
> Hmm, rfkill changes usually go through net tree so unless they want me
> to push it though I'll just ACK the new keycode.
> 
> > 
> > Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>

Acked-by: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>

Regards

Marcel


--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
