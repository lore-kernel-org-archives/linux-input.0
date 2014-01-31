From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Fri, 31 Jan 2014 11:20:10 -0500
Message-ID: <CAN+gG=EB5DguOQ7+ZdUbRFcBt3qj3qeW6kiq-eJP7SCFjrsriA@mail.gmail.com>
References: <1674012.xCMptsh8XR@myon.chronox.de>
	<2193004.SWLhWZ2AvA@tauon>
	<CAN+gG=HAXE4LT_tN+3tE8-T_L5g+2HAE35CN+z8KCEQcmJ=JWw@mail.gmail.com>
	<13914184.mVhhUrzN60@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <13914184.mVhhUrzN60@myon.chronox.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 30, 2014 at 11:31 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Donnerstag, 30. Januar 2014, 22:50:25 schrieb Benjamin Tissoires:
>
> Hi Benjamin,
>
>> > Can you please help me how to do that? I install Windows in a KVM with
>> > the mouse device as a USB-passthrough device -- shall I detach the Linux
>> > USB driver?
>>
>> No, you don't have to detach the Linux USB driver (it's done for you
>> by KVM IIRC).
>
> Correct, libvirtd is the one that detaches the driver when I start the VM.
>>
>> > Now, shall I use hid-recorder on that device or rather usbmon while
>> > Windows is booting?
>>
>> usbmon is the tool you need. hid-recorder will not work because the
>> hid subsystem will be disconnected as the device is used by Windows.
>>
>> You can even use wireshark now. It gives you a nice interface and
>> interpretation of the USB packets :)
>
> Please see attached for the USB sniffing on the USB bus with the Crucialtec
> touch pad when Windows starts up and shuts down. To drive the device, Windows
> uses the Crucialtec driver according to its device settings display.
>
> The attached log contains the log information for the mouse (device 001:005)
> and the USB bridge (device 001:002). I cut out the listing for the touch pad
> which is also attached to that bridge.
>
> The strange thing, however, is the following: the mouse works in Windows when
> I do not sniff on the USB bus using usbmon. But as soon as I start sniffing,
> it does not work any more.
>
> Is that log helpful?

Not really :(
I would have expected to see something like that:
XXXXXXXXXXXXXXXX XXXXXXXXXX S Co:1:XXX:0 s 21 09 0202 0002 0004 4 = XXXXXXXX
XXXXXXXXXXXXXXXX XXXXXXXXXX C Co:1:XXX:0 0 4 >

(SET_REPORT on the report ID 02 with a data length of 4)

The capture seems to confuse the windows driver and it is not
initialized correctly.

Long shot: maybe if you start the capture before attaching the device
to the Windows VM (or launching it) it will be in a better shape.

I would say that as long as the device do not work under the VM with
the capture, we are really screwed.

Cheers,
Benjamin
