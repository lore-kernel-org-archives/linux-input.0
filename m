From: Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: i2c_hid issues with sensor hub on Surface Pro 3
Date: Thu, 5 Feb 2015 18:44:26 +0000
Message-ID: <CAFQExzmVOsXo-tWrMsFqckAxvRQvV9F_xRr6AqxxPHODQ11Qcw@mail.gmail.com>
References: <CAFQExznHNsnKcz+MhEyq2qJfag3eEgqEJVFecumduus0KZwF0A@mail.gmail.com>
 <CAN+gG=HN8t21CMm9NeHOWYnawyYGQBf8-RP9MvaS7p_e57Uoxg@mail.gmail.com>
 <CAFQExzmd0-y2QH6e9cBELa1Yj82zh3z7mJFE5sJ3pc-d55U9zA@mail.gmail.com> <CAN+gG=F_JZrYCeqiUAKrwFxjgGNiJj6CXEXboV54H5zcwBP3JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:57714 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbBESoz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 13:44:55 -0500
Received: by mail-wg0-f41.google.com with SMTP id a1so9281773wgh.0
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2015 10:44:54 -0800 (PST)
In-Reply-To: <CAN+gG=F_JZrYCeqiUAKrwFxjgGNiJj6CXEXboV54H5zcwBP3JQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Indeed you are correct, looks like one of the devices listed there is
the sensor hub - so I'm barking up the wrong tree.

Will have to move on to the sensor drivers themselves I guess. Thanks
for your help!

Yani

On Thu, Feb 5, 2015 at 6:10 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Thu, Feb 5, 2015 at 12:56 PM, Yani Ioannou <yani.ioannou@gmail.com> wrote:
>> Hi Benjamin,
>>
>> As far as I'm aware the sensor hub didn't show up under any kernel (I'll try
>> an earlier kernel to figure out if this is true) I didn't mean to say this
>> is a regression, sorry.
>
> Oh, my bad.
>
>>
>> The errors for the MSHW0030 device seem to be fatal - since the initial
>> report request fails, the driver doesn't try to work with the device. The
>> NTRG device however, is as you suggest, and it is fine - I shouldn't have
>> included the output for that device perhaps.
>
> Not being able to retrieve the reports should not be fatal in i2c_hid.
>
> There should be 2 devices showing up in:
> /sys/kernel/debug/hid/
> (if you have debugfs mounted in /sys/kernel/debug)
>
> One of them is the Ntrig (0018:1B96:1B05.*), the other should be the sensor hub.
>
> Can you paste here the content of the rdesc file which is in the sensor_hub dir?
>
> And yes, if there is no sensor hub device showing under the hid
> debugfs dir (or under /sys/bus/hid/devices), that means that i2c-hid
> has removed the device.
>
> Cheers,
> Benjamin
>
>>
>> So in summary I'm trying to work out why the sensor hub driver is never
>> loaded, and as far as I can tell this is why.
>>
>> Thanks,
>> Yani
>>
>>
>> On Thu, Feb 5, 2015, 17:44 Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On Thu, Feb 5, 2015 at 11:29 AM, Yani Ioannou <yani.ioannou@gmail.com>
>>> wrote:
>>> > Hi,
>>> >
>>> > I've been trying to debug why the sensor hub on a Surface pro 3 isn't
>>> > detected in the latest mainline kernel (3.19-rc6). When I enable debug
>>> > I get the following output showing a bunch of errors trying to
>>> > communicate with the device MSHW0030, which seems to be the sensor
>>> > hub.
>>>
>>> These errors do not bother me that much. They appear when we try to
>>> read the reports from the device, and this has been known to not work
>>> on many devices.
>>> As long as the device emits by itself the reports, we are fine.
>>>
>>> There has been very few changes in the v3.19 series regarding i2c-hid,
>>> so if you get the same debug output on a v3.18 kernel (and the sensor
>>> hub works), I would think that the problem you are having is in the
>>> IIO subsystem.
>>>
>>> Cheers,
>>> Benjamin
>>>
>>> >
>>> > I've looked into the code/protocol a little and it seems the initial
>>> > feature reports that are returned are of incorrect size, but I don't
>>> > understand why without much prior knowledge of the domain.
>>> >
>>> > Any help and/or further debugging tips would be greatly appreciated.
>>> >
>>> > Thanks,
>>> > Yani
>>> >
>>> > [ 83.133219] i2c_hid i2c-MSHW0030:00: Fetching the HID descriptor
>>> > [ 83.133224] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=01 00
>>> > [ 83.134826] i2c_hid i2c-MSHW0030:00: HID Descriptor: 1e 00 00 01 bf
>>> > 08 02 00 03 00 3f 00 04 00 3f 00 05 00 06 00 5e 04 c4 07 04 00 00 00
>>> > 00 00
>>> > [ 83.134928] i2c_hid i2c-MSHW0030:00: entering i2c_hid_parse
>>> > [ 83.134932] i2c_hid i2c-MSHW0030:00: i2c_hid_hwreset
>>> > [ 83.134935] i2c_hid i2c-MSHW0030:00: i2c_hid_set_power
>>> > [ 83.134938] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 00 08
>>> > [ 83.135629] i2c_hid i2c-MSHW0030:00: resetting...
>>> > [ 83.135633] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 00 01
>>> > [ 83.136305] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: waiting...
>>> > [ 83.138471] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: finished.
>>> > [ 83.138475] i2c_hid i2c-MSHW0030:00: asking HID report descriptor
>>> > [ 83.138477] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=02 00
>>> > [ 83.191568] i2c_hid i2c-MSHW0030:00: Report Descriptor: 05 20 09 01
>>> > a1 01 85 01 05 20 09 73 a1 00 0a 09 03 15 00 25 02 75 08 95 01 a1 02
>>> > 0a 30 08 0a 31 08 0a 32 08 b1 00 c0 0a 0e 03 15 00 27 ff ff ff ff 75
>>> > 20 95 01 55 00 b1 02 0a 52 14 15 00 26 ff
>>> > [ 83.193819] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.193822] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 31 02
>>> > 06 00
>>> > [ 83.194952] i2c_hid i2c-MSHW0030:00: report (len=14): 0e 00 01 01 60
>>> > 00 00 00 14 00 01 06 02 10
>>> > [ 83.194957] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.194959] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 32 02
>>> > 06 00
>>> > [ 83.196162] i2c_hid i2c-MSHW0030:00: report (len=14): 0e 00 02 01 10
>>> > 00 00 00 00 00 01 06 02 10
>>> > [ 83.196166] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.196167] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 33 02
>>> > 06 00
>>> > [ 83.196991] i2c_hid i2c-MSHW0030:00: report (len=14): 0e 00 03 01 c8
>>> > 00 00 00 00 00 01 06 02 c8
>>> > [ 83.196998] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.197000] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 34 02
>>> > 06 00
>>> > [ 83.198233] i2c_hid i2c-MSHW0030:00: report (len=30): 1e 00 04 01 64
>>> > 00 00 00 3c 00 0a 00 64 00 0b 00 64 00 40 1f f4 01 41 1f 64 00 01 06
>>> > 02 64
>>> > [ 83.198238] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.198240] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 35 02
>>> > 06 00
>>> > [ 83.199093] i2c_hid i2c-MSHW0030:00: report (len=14): 0e 00 05 01 10
>>> > 00 00 00 00 00 01 06 02 10
>>> > [ 83.199096] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.199098] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 36 02
>>> > 06 00
>>> > [ 83.199699] i2c_hid i2c-MSHW0030:00: report (len=14): 0e 00 06 01 10
>>> > 00 00 00 00 00 01 06 02 10
>>> > [ 83.199703] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.199705] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 20 06 00
>>> > [ 83.202008] i2c_hid i2c-MSHW0030:00: report (len=63): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.202011] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:63 / ret_size:0
>>> > [ 83.202014] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.202015] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 21 06 00
>>> > [ 83.204331] i2c_hid i2c-MSHW0030:00: report (len=63): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.204335] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:63 / ret_size:0
>>> > [ 83.204337] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.204339] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 22 06 00
>>> > [ 83.205447] i2c_hid i2c-MSHW0030:00: report (len=19): 13 00 22 cb a8
>>> > 07 02 03 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.205451] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.205453] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 23 06 00
>>> > [ 83.206745] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.206749] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.206752] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.206753] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 24 06 00
>>> > [ 83.207780] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.207783] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.207786] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.207788] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 25 06 00
>>> > [ 83.208803] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.208806] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.208809] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.208811] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 26 06 00
>>> > [ 83.209824] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.209826] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.209828] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.209830] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 27 06 00
>>> > [ 83.210588] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.210590] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.210592] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.210594] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 28 06 00
>>> > [ 83.211659] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.211661] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.211663] i2c_hid i2c-MSHW0030:00: i2c_hid_get_report
>>> > [ 83.211665] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 3f
>>> > 02 29 06 00
>>> > [ 83.212971] i2c_hid i2c-MSHW0030:00: report (len=19): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.212975] i2c_hid i2c-MSHW0030:00: error in i2c_hid_init_report
>>> > size:19 / ret_size:0
>>> > [ 83.215406] i2c_hid i2c-MSHW0030:00: i2c_hid_set_power
>>> > [ 83.215410] i2c_hid i2c-MSHW0030:00: __i2c_hid_command: cmd=05 00 01 08
>>> > [ 83.268607] i2c_hid i2c-NTRG0001:01: Fetching the HID descriptor
>>> > [ 83.268613] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=01 00
>>> > [ 83.270130] i2c_hid i2c-NTRG0001:01: HID Descriptor: 1e 00 00 01 c7
>>> > 01 02 00 03 00 1f 00 00 00 00 00 05 00 06 00 96 1b 05 1b 04 00 00 00
>>> > 00 00
>>> > [ 83.270211] i2c_hid i2c-NTRG0001:01: entering i2c_hid_parse
>>> > [ 83.270213] i2c_hid i2c-NTRG0001:01: i2c_hid_hwreset
>>> > [ 83.270215] i2c_hid i2c-NTRG0001:01: i2c_hid_set_power
>>> > [ 83.270216] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 00 08
>>> > [ 83.270902] i2c_hid i2c-NTRG0001:01: resetting...
>>> > [ 83.270904] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 00 01
>>> > [ 83.271685] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: waiting...
>>> > [ 83.461132] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: finished.
>>> > [ 83.461137] i2c_hid i2c-NTRG0001:01: asking HID report descriptor
>>> > [ 83.461140] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=02 00
>>> > [ 83.471968] i2c_hid i2c-NTRG0001:01: Report Descriptor: 05 0d 09 02
>>> > a1 01 85 01 09 20 35 00 a1 00 09 32 09 42 09 44 09 3c 09 45 15 00 25
>>> > 01 75 01 95 05 81 02 95 03 81 03 05 01 09 30 75 10 95 01 a4 55 0e 65
>>> > 11 46 ec 09 26 80 25 81 42 09 31 46 9d 06
>>> > [ 83.472540] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.472542] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3c 02
>>> > 06 00
>>> > [ 83.473498] i2c_hid i2c-NTRG0001:01: report (len=9): 00 00 00 00 00 00
>>> > 00 00 00
>>> > [ 83.473507] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:9 / ret_size:0
>>> > [ 83.473515] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.473520] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3b 02
>>> > 06 00
>>> > [ 83.473867] i2c_hid i2c-NTRG0001:01: report (len=5): 00 00 00 00 00
>>> > [ 83.473872] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:5 / ret_size:0
>>> > [ 83.473875] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.473878] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3f
>>> > 02 11 06 00
>>> > [ 83.474493] i2c_hid i2c-NTRG0001:01: report (len=5): 03 01 1b 29 a9
>>> > [ 83.474497] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:5 / ret_size:259
>>> > [ 83.474500] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.474503] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3f
>>> > 02 15 06 00
>>> > [ 83.475186] i2c_hid i2c-NTRG0001:01: report (len=8): 03 01 1b 29 a9 19
>>> > 9f 9a
>>> > [ 83.475190] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:8 / ret_size:259
>>> > [ 83.475192] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.475195] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3f
>>> > 02 18 06 00
>>> > [ 83.476035] i2c_hid i2c-NTRG0001:01: report (len=15): 03 01 1b 29 a9
>>> > 19 9f 9a 19 a4 bf dd c2 f3 29
>>> > [ 83.476039] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:15 / ret_size:259
>>> > [ 83.476041] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.476044] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 34 02
>>> > 06 00
>>> > [ 83.476354] i2c_hid i2c-NTRG0001:01: report (len=4): 04 00 04 0a
>>> > [ 83.476360] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.476363] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3a 02
>>> > 06 00
>>> > [ 83.476673] i2c_hid i2c-NTRG0001:01: report (len=4): 00 00 00 00
>>> > [ 83.476676] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:4 / ret_size:0
>>> > [ 83.476679] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.476682] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 3f
>>> > 02 1b 06 00
>>> > [ 83.482978] i2c_hid i2c-NTRG0001:01: report (len=259): 03 01 1b 29 a9
>>> > 19 9f 9a 19 a4 bf dd c2 f3 29 e1 34 44 89 23 3f 8c 56 79 f3 fc 57 d0
>>> > ea 56 46 23 9a 15 d8 5a de 99 5e 2f fc 9f e2 f4 73 df d5 c5 36 ed 8d
>>> > 4e 28 db 8c 34 a3 b0 19 5c 4f ae bf 9c
>>> > [ 83.482986] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.482988] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 35 02
>>> > 06 00
>>> > [ 83.485124] i2c_hid i2c-NTRG0001:01: report (len=63): 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> > 00 00 00 00 00 00 00 00 00 00 00 00
>>> > [ 83.485127] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:63 / ret_size:0
>>> > [ 83.485128] i2c_hid i2c-NTRG0001:01: i2c_hid_get_report
>>> > [ 83.485130] i2c_hid i2c-NTRG0001:01: __i2c_hid_command: cmd=05 00 37 02
>>> > 06 00
>>> > [ 83.486010] i2c_hid i2c-NTRG0001:01: report (len=7): 00 00 00 00 00 00
>>> > 00
>>> > [ 83.486012] i2c_hid i2c-NTRG0001:01: error in i2c_hid_init_report
>>> > size:7 / ret_size:0
>>> > [ 83.486096] input: NTRG0001:01 1B96:1B05 Pen as
>>> >
>>> > /devices/pci0000:00/INT33C3:00/i2c-10/i2c-NTRG0001:01/0018:1B96:1B05.0008/input/input16
>>> > [ 83.486306] input: NTRG0001:01 1B96:1B05 as
>>> >
>>> > /devices/pci0000:00/INT33C3:00/i2c-10/i2c-NTRG0001:01/0018:1B96:1B05.0008/input/input17
>>> > [ 83.488543] hid-multitouch 0018:1B96:1B05.0008: input,hidraw4:
>>> > <UNKNOWN> HID v1.00 Mouse [NTRG0001:01 1B96:1B05] on
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe linux-input"
>>> > in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
