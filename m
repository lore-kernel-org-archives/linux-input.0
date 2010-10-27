From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Wed, 27 Oct 2010 15:20:09 -0500
Message-ID: <0D753D10438DA54287A00B027084269764819C63F4@AUSP01VMBX24.collaborationhost.net>
References: <20101025180320.GA4725@const.famille.thibault.fr>
 <4CC6E9D8.8010201@triadsys.com>
 <20101026161820.GE13097@core.coreip.homeip.net>
 <4CC7426C.8040502@triadsys.com>
 <20101027091029.GB28895@core.coreip.homeip.net>
 <20101027120513.GT4725@const.famille.thibault.fr>
 <99F91536-4413-430C-9932-7CEF6AB656DB@gmail.com>
 <20101027152242.GO4725@const.famille.thibault.fr>
 <20101027160842.GB8745@core.coreip.homeip.net>
 <4CC870BB.2050000@triadsys.com>
 <20101027192508.GA29761@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101027192508.GA29761@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tom Vier <tom@triadsys.com>
Cc: Samuel Thibault <sthibault@debian.org>, "594089@bugs.debian.org" <594089@bugs.debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Wednesday, October 27, 2010 12:25 PM, Dmitry Torokhov wrote:
>> 
>> I: Bus=0003 Vendor=046d Product=c30a Version=0110
>> N: Name="Logitech Logitech USB Keyboard"
>> P: Phys=usb-0000:00:13.0-2/input0
>> S: Sysfs=/devices/pci0000:00/0000:00:13.0/usb5/5-2/5-2:1.0/input/input9
>> U: Uniq=
>> H: Handlers=kbd event2
>> B: EV=120013
>> B: KEY=1000000000007 ff800000000007ff febeffdfffefffff fffffffffffffffe
>> B: MSC=10
>> B: LED=1f
>> 
>> I: Bus=0003 Vendor=046d Product=c30a Version=0110
>> N: Name="Logitech Logitech USB Keyboard"
>> P: Phys=usb-0000:00:13.0-2/input1
>> S: Sysfs=/devices/pci0000:00/0000:00:13.0/usb5/5-2/5-2:1.1/input/input10
>> U: Uniq=
>> H: Handlers=kbd mouse2 event3
>> B: EV=17
>> B: KEY=fffffffffffff f8403340000 60d8fafd01d008 1f000000000000 0
>> B: REL=103
>> B: MSC=10
>> 
>
>
> Hmm, this keyboard registers 2 input devices... I wonder, if you press
> CapsLock/Favories and RightShift/Previous and monitor both event devices
> with evtest - will it report events on both devices at once?

I haven't really been following this thread but I think the two input devices
is normal if the keyboard has multi-media keys.  All the "extra" keys show up
as a separate input device.

You might get the CapsLock and RightShift events on one device and the Favorites
and Previous events on the other.

Hartley