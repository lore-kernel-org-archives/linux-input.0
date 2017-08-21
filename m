From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Mon, 21 Aug 2017 08:45:22 -0700
Message-ID: <20170821154522.GA21773@dtor-ws>
References: <20170818193436.GA31365@dtor-ws>
 <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 21, 2017 at 10:52:11AM +0200, Damjan Georgievski wrote:
> On 18 August 2017 at 21:34, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > The touchpad on Lenovo Carbon X1 Gen 5 (2017 - Kabylake) is accessible over
> > SMBUS/RMI, so let's activate it by default.
> 
> the patch over latest Linus 4.13-rc5 makes the trackpoint device to
> not appear after boot.
> 
> Sometimes it  spontaneuosly appears 100-200 seconds after boot.
> 
> It does appear after suspend/resume. And it does appear after `rmmod
> psmouse; modprobe psmouse`.

Hmm, I do not observe this on:

Handle 0x000B, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: N1MET37W (1.22 )
        Release Date: 07/04/2017
...
        BIOS Revision: 1.22
        Firmware Revision: 1.15

Handle 0x000C, DMI type 1, 27 bytes
System Information
        Manufacturer: LENOVO
        Product Name: 20HQS0EG02
        Version: ThinkPad X1 Carbon 5th
...
        SKU Number: LENOVO_MT_20HQ_BU_Think_FM_ThinkPad X1 Carbon 5th
        Family: ThinkPad X1 Carbon 5th

I wonder if we have different configs...

> 
> 
> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
> Mouse". Middle button scrolling is not enabled by default.

I think this will be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch/?id=ec667683c532c93fb41e100e5d61a518971060e2

> 
> hardware is:
> Lenovo ThinkPad X1 Carbon 5th, model 20HQS0LV00
> DMI: LENOVO 20HQS0LV00/20HQS0LV00, BIOS N1MET37W (1.22 ) 07/04/2017
> 

Thanks.

-- 
Dmitry
