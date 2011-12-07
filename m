From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/3 v2] usb/hid-core: drain URB queue when going to suspend
Date: Wed, 7 Dec 2011 10:42:55 +0800
Message-ID: <CAGS+omBvSWz4vBsMDkwk3oge_+k64tqSkrHyF5-C5_LZte_hDw@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321529030-7845-1-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 17, 2011 at 7:23 PM, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wr=
ote:
>
> In some situations, trying to suspend a laptop with an attached USB k=
eyboard
> would fail if both NumLock and CapsLock LEDs were lit.
> This was due to a race condition between asynchronously submitted
> LED-manipulating CTRL URBs and the suspend process.
>
> This is a different solution to the same problem highlighted here:
> https://lkml.org/lkml/2011/9/2/391
>
> These patches are against Jiri's hid/for-next branch.
>
> Daniel Kurtz (3):
> =A0HID: usbhid: remove LED_ON
> =A0HID: usbhid: hid-core: submit queued urbs before suspend
> =A0HID: usbhid: defer LED setting to a workqueue
>
> Differences since v1:
> =A0* Rebase on hid/for-next
> =A0* Solve race with usbhid_stop() [reported by Oliver Neukum]
>

Hi Jiri,

Any chance you can take a look at this patch set?

-Dan

> =A0drivers/hid/hid-input.c =A0 =A0 =A0 | =A0 42 +++++++
> =A0drivers/hid/usbhid/hid-core.c | =A0241 ++++++++++++++++++++++++---=
--------------
> =A0drivers/hid/usbhid/usbhid.h =A0 | =A0 =A03 +-
> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A04 files changed, 187 insertions(+), 101 deletions(-)
>
> --
> 1.7.3.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
