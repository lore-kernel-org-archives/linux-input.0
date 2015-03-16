From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: wacom: ask for a in-prox report when it was
 missed
Date: Mon, 16 Mar 2015 20:20:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503162020050.25438@pobox.suse.cz>
References: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz> <CANRwn3R7nBPxPynexP+yU43puxgNmj=35ghh01ioUqmNjdTy+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRwn3R7nBPxPynexP+yU43puxgNmj=35ghh01ioUqmNjdTy+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 16 Mar 2015, Jason Gerecke wrote:

> This update seems to have solved the issue I was having earlier. I do
> still see some weird behavior with the Intuos3 though. For whatever
> reason, if a tool is in prox and no client is connected, the device
> will repeatedly connect and disconnect from the bus. For example,
> while sitting at a VT after connecting the device:
> 
> [  209.890431] usb 2-1.5.4: new full-speed USB device number 10 using ehci-pci
> [  209.992189] input: Wacom Intuos3 6x8 as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/0003:056A:00B1.0009/input/input26
> [  209.992475] input: Wacom Intuos3 6x8 Pad as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/0003:056A:00B1.0009/input/input27
> [  209.992846] wacom 0003:056A:00B1.0009: hidraw4: USB HID v1.00 Mouse
> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
> [  213.022545] usb 2-1.5.4: USB disconnect, device number 10
> [  213.344055] usb 2-1.5.4: new full-speed USB device number 11 using ehci-pci
> [  213.445779] input: Wacom Intuos3 6x8 as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/0003:056A:00B1.000A/input/input28
> [  213.446185] input: Wacom Intuos3 6x8 Pad as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/0003:056A:00B1.000A/input/input29
> [  213.446703] wacom 0003:056A:00B1.000A: hidraw4: USB HID v1.00 Mouse
> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
> [  214.815925] usb 2-1.5.4: USB disconnect, device number 11
> [  215.246142] usb 2-1.5.4: new full-speed USB device number 12 using ehci-pci
> 
> [ ... and so on ...]
> 
> It makes using the device from a VT difficult (e.g. for debugging),
> but in the typical case where X is started shortly after boot and
> hotplugs devices as soon as they're available it shouldn't pose a
> problem. If Benjamin has any ideas I'd like to hear them, but in the
> meantime I'm comfortable seeing this go upstream:
> 
> Acked-by: Jason Gerecke <killertofu@gmail.com>

Applied to for-4.1/wacom, thanks.

-- 
Jiri Kosina
SUSE Labs
