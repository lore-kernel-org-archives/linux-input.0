From: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dead USB devices after resume [mmotm 2009-02-10-16-35]
Date: Wed, 11 Feb 2009 10:54:08 +0100
Message-ID: <4992A040.6080302@gmail.com>
References: <200902110036.n1B0aBZs013975@imap1.linux-foundation.org> <49928FDB.5020007@gmail.com> <200902111044.57869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902111044.57869.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 02/11/2009 10:44 AM, Rafael J. Wysocki wrote:
> Please test current mainline, it may be a regression in there.

OK, will do.

> How exactly are the failing devices connected to the box?

There is a hub in the kbd. The mouse and kbd is behind it, I suppose:

/:  Bus 08.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 07.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/3p, 12M
        |__ Port 1: Dev 3, If 0, Class=HID, Driver=usbhid, 12M
        |__ Port 1: Dev 3, If 1, Class=HID, Driver=usbhid, 12M
        |__ Port 2: Dev 4, If 0, Class=HID, Driver=usbhid, 1.5M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M

There is also a wheel at 6.3 if 1...

Bus 006 Device 004: ID 045e:00f0 Microsoft Corp.
Bus 006 Device 003: ID 0458:004c KYE Systems Corp. (Mouse Systems) Slimstar Pro
Keyboard
Bus 006 Device 002: ID 04b4:2050 Cypress Semiconductor Corp.
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

I may try to plug the mouse directly to the root hub if it might help anyhow.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
