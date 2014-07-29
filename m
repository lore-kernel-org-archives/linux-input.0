From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Trouble with an HP stylus
Date: Tue, 29 Jul 2014 10:45:53 -0400
Message-ID: <53D7B3A1.5000603@gmail.com>
References: <2325454.r4RE9vHMoF@romarin> <alpine.LNX.2.00.1407291147190.16390@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:34998 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaG2Om3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 10:42:29 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so9359670qaq.39
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 07:42:28 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1407291147190.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?UTF-8?B?w4lyaWMgQnJ1bmV0?= <Eric.Brunet@lps.ens.fr>, linux-input <linux-input@vger.kernel.org>

Hi Jiri, Eric,


On Tue, Jul 29, 2014 at 5:50 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 24 Jul 2014, =C3=89ric Brunet wrote:
>
>> I have a HP EliteBook Revolve 810 (which is a hybrid laptop/tablet) =
with
>> the HP active pen that goes with it. I have installed fedora 20 (ker=
nel
>> 3.15.6-200.fc20.x86_64) on this, and the pen does not work out of th=
e box.
>> Playing with evtest, it appears that the kernel reports the X coordi=
nate in
>> ABS_X and in ABS_Y, while the Y coordinate goes into ABS_Z and ABS_R=
X; here
>> are a few lines of output:
>>
>> Event: time 1406153996.865044, -------------- SYN_REPORT -----------=
-
>> Event: time 1406153996.873047, type 3 (EV_ABS), code 0 (ABS_X), valu=
e 1087
>> Event: time 1406153996.873047, type 3 (EV_ABS), code 1 (ABS_Y), valu=
e 1087
>> Event: time 1406153996.873047, type 3 (EV_ABS), code 2 (ABS_Z), valu=
e 1599
>> Event: time 1406153996.873047, type 3 (EV_ABS), code 3 (ABS_RX), val=
ue 1599
>>
>> Of course, XOrg's evdev driver is confused and the pointer is stuck =
on the
>> diagonal X=3DY.
>>
>> I guess this hardware needs a new quirk to usbhid, unless there is a=
lready
>> a way to correct it ?
>>
>> Here is the content of /sys/class/input/event8/device/uevent:
>>
>> PRODUCT=3D3/3eb/840b/111
>> NAME=3D"Atmel Atmel maXTouch Digitizer Pen"
>> PHYS=3D"usb-0000:00:1a.0-1.1/input0"
>> UNIQ=3D""
>> PROP=3D0
>> EV=3D1b
>> KEY=3Dc01 1 0 0 0 0
>> ABS=3D100000f
>> MSC=3D10
>> MODALIAS=3Dinput:b0003v03EBp840Be0111-
>> e0,1,3,4,k100,140,14A,14B,ra0,1,2,3,18,m4,lsfw
>>
>> I hope I gave enough information on this. I don't read the mailing l=
ist,
>> please CC any answer.
>
> Does the patch below fix the problem for you please?
>

I have already seen this Atmel panel, and the problem was that they use=
d twice X then twice Y to report coordinates:

0x05, 0x01,                    //     Usage Page (Generic Desktop)    5=
90
0x55, 0x0e,                    //     Unit Exponent (-2)              5=
92
0x65, 0x11,                    //     Unit (Centimeter,SILinear)      5=
94
0x35, 0x00,                    //     Physical Minimum (0)            5=
96
0x75, 0x10,                    //     Report Size (16)                5=
98
0x95, 0x02,                    //     Report Count (2)                6=
00
0x46, 0x00, 0x0a,              //     Physical Maximum (2560)         6=
02
0x26, 0xff, 0x0f,              //     Logical Maximum (4095)          6=
05
0x09, 0x30,                    //     Usage (X)                       6=
08
0x81, 0x02,                    //     Input (Data,Var,Abs)            6=
10
0x46, 0xa0, 0x05,              //     Physical Maximum (1440)         6=
12
0x26, 0xff, 0x0f,              //     Logical Maximum (4095)          6=
15
0x09, 0x31,                    //     Usage (Y)                       6=
18
0x81, 0x02,                    //     Input (Data,Var,Abs)            6=
20

I have no ideas why they did that, but this is a pretty bad idea. I tho=
ught at the time that it was just a prototype and that they would fix i=
t for the release, but I was wrong.

I think, a better patch would simply consist in that:

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..b70d4c3 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -603,7 +603,7 @@ static void hidinput_configure_usage(struct hid_inp=
ut *hidinput, struct hid_fiel
                        if (field->flags & HID_MAIN_ITEM_RELATIVE)
                                map_rel(usage->hid & 0xf);
                        else
-                               map_abs(usage->hid & 0xf);
+                               map_abs_clear(usage->hid & 0xf);
                        break;
=20
                case HID_GD_HATSWITCH:

-----

I have the report descriptors and some traces of it, so I could definit=
ively make some more tests, but I will have to first finish the wacom b=
its I scheduled for today.

Eric, if you can give a shot to my patch (you can try Jiri's too, but I=
 don't think it will work), that would simplify my process, and I will =
just have to reformat/submit it properly.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
