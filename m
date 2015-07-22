From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 16:41:31 +0200
Message-ID: <55AFAB9B.2090101@suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721170133.GA39076@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On 07/21/2015 07:01 PM, Dmitry Torokhov wrote:
> No, this is benign. I guess your keyboard has more LEDs than input
> system has defined or several usages refer to the same LED.
> 
> Can you try debug patch below and post the messages?
> 

[  101.805120] usb 3-4: new low-speed USB device number 3 using xhci_hcd
[  101.979584] usb 3-4: New USB device found, idVendor=046d, idProduct=c50e
[  101.979589] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  101.979592] usb 3-4: Product: USB Receiver
[  101.979594] usb 3-4: Manufacturer: Logitech
[  101.979805] usb 3-4: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[  101.989010] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989014] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989017] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989019] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989021] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989023] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989025] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989027] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
[  101.989091] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:046D:C50E.0003/input/input14
[  102.039320] ------------[ cut here ]------------
[  102.039329] WARNING: CPU: 6 PID: 168 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()

(5 WARNINGs as before)

[  102.040729] hid-generic 0003:046D:C50E.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-4/input0
