From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Thu, 30 Jan 2014 22:50:25 -0500
Message-ID: <CAN+gG=HAXE4LT_tN+3tE8-T_L5g+2HAE35CN+z8KCEQcmJ=JWw@mail.gmail.com>
References: <1674012.xCMptsh8XR@myon.chronox.de>
	<2981174.bDZe6OjLCj@myon.chronox.de>
	<CAN+gG=F_L1UdSqpi2d--JeerADT66s2d04t8hv+ZoVSL6dQgbg@mail.gmail.com>
	<2193004.SWLhWZ2AvA@tauon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <2193004.SWLhWZ2AvA@tauon>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 30, 2014 at 5:07 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Donnerstag, 30. Januar 2014, 16:44:02 schrieb Benjamin Tissoires:
>
> Hi Benjamin,
>
>>Hi Stephan,
>>
>>thanks for the traces.
>>Well, the device definitively presents an Output and an Input report
>>on the report ID 2. That means that the windows driver can send and
>>read configuration to the trackpoint through this report.
>>
>>I think our best chance here is to capture the initialization protocol
>>from a Windows virtual machine, and then mimic the behavior under
>>Linux.
>
> Thanks.
>
> Can you please help me how to do that? I install Windows in a KVM with
> the mouse device as a USB-passthrough device -- shall I detach the Linux
> USB driver?

No, you don't have to detach the Linux USB driver (it's done for you
by KVM IIRC).

>
> Now, shall I use hid-recorder on that device or rather usbmon while
> Windows is booting?

usbmon is the tool you need. hid-recorder will not work because the
hid subsystem will be disconnected as the device is used by Windows.

You can even use wireshark now. It gives you a nice interface and
interpretation of the USB packets :)

Cheers,
Benjamin
