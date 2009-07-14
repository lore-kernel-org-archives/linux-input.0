From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] Input: add MAX7359 key switch controller driver, v2
Date: Tue, 14 Jul 2009 15:53:17 +0530
Message-ID: <5d5443650907140323l6cc06151nbec94d5d8646c60a@mail.gmail.com>
References: <4A04E5EA.7000103@samsung.com>
	 <5d5443650906191038o797e0c3eu8234a56ee247ea68@mail.gmail.com>
	 <5d5443650907130152t420e9426q762c24bdb1b29aae@mail.gmail.com>
	 <20090713093147.GJ10819@dtor-d630.eng.vmware.com>
	 <4A5BF6F0.6020403@samsung.com>
	 <001801ca044c$428839d0$c798ad70$%szyprowski@samsung.com>
	 <20090714082452.GH2822@dtor-d630.eng.vmware.com>
	 <002a01ca0462$8b750a90$a25f1fb0$%szyprowski@samsung.com>
	 <5d5443650907140211i4c6e4a49q9c055dc1e91071da@mail.gmail.com>
	 <002b01ca046c$7f9fd240$7edf76c0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:50729 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbZGNKXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 06:23:18 -0400
In-Reply-To: <002b01ca046c$7f9fd240$7edf76c0$%szyprowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kim Kyuwon <q1.kim@samsung.com>, Kim Kyuwon <chammoru@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Hi Market,

On Tue, Jul 14, 2009 at 3:48 PM, Marek
Szyprowski<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Tuesday, July 14, 2009 11:12 AM, Trilok Soni wrote:
>
>> On Tue, Jul 14, 2009 at 2:37 PM, Marek
>> Szyprowski<m.szyprowski@samsung.com> wrote:
>> > Hello,
>> >
>> > On Tuesday, July 14, 2009 10:25 AM, Dmitry Torokhov wrote:
>> >
>> >> On Tue, Jul 14, 2009 at 08:28:05AM +0200, Marek Szyprowski wrote:
>> >> > Hello,
>> >> > On Tuesday, July 14, 2009 5:10 AM, Kim Kyuwon wrote:
>> >> > > Dmitry Torokhov wrote:
>> >> > > > On Mon, Jul 13, 2009 at 02:22:10PM +0530, Trilok Soni wrote=
:
>> >> > > >> I don't see this driver picked up yet in your -next branch=
=2E We should
>> >> > > >> target this driver to be mainlined in next merge window. T=
his is very
>> >> > > >> important driver for some of the embedded systems, includi=
ng palm pre
>> >> > > >> :)
>> >> > > > I was wondering if somebody could test the patch below and =
if it still
>> >> > > > works then I will apply to the next branch. Thanks!
>> >> > > >
>> >> > >
>> >> > > Dear Marek,
>> >> > >
>> >> > > Because I don't have the NCP board(which includes the max7359=
 keypad)
>> >> > > now, I can't test this patch. Marek, could you please test th=
is patch?
>> >> >
>> >> > I would like to, but I could not find the base version to which=
 I can apply
>> >> > that patch. I've tried v2 version posted in '[PATCH] Input: add=
 MAX7359 key
>> >> > switch controller driver, v2' mail from Sat 2009-05-09 04:10 wi=
th 2 patches
>> >> > posted in replies to that main, but the latest patch still fail=
s to apply.
>> >> >
>> >> > Could someone send me a complete patch, so I can do a test?
>> >> >
>> >>
>> >> Sending everything as attachments, maybe that will help...
>> >
>> > Ok. I've did the tests.
>> >
>> > MAX7359 keypad driver works after your patch, but reports much mor=
e events than
>> > the previous version. In this test I pressed quickly the first but=
ton on the
>> > keypad.
>> >
>> > Old version:
>> > NCP:~# hexdump /dev/input/event0
>> > 0000000 0037 0000 e733 000b 0001 00e7 0001 0000
>> > 0000010 0037 0000 e748 000b 0000 0000 0000 0000
>> > 0000020 0037 0000 94e2 000d 0001 00e7 0000 0000
>> > 0000030 0037 0000 94f3 000d 0000 0000 0000 0000
>> >
>>
>> Please use evtest instead. It will give better output atleast.
>
> Ok.
>
> Old version (clean v2 patch):
>
> NCP:~# evtest /dev/input/event0
> Input driver version is 1.0.0
> Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
> Input device name: "max7359"
> Supported events:
> =A0Event type 0 (Sync)
> =A0Event type 1 (Key)
> =A0 =A0Event code 107 (End)
> =A0 =A0Event code 139 (Menu)
> =A0 =A0Event code 148 (Prog1)
> =A0 =A0Event code 149 (Prog2)
> =A0 =A0Event code 177 (ScrollUp)
> =A0 =A0Event code 178 (ScrollDown)
> =A0 =A0Event code 212 (Camera)
> =A0 =A0Event code 231 (?)
> =A0 =A0Event code 474 (?)
> =A0Event type 20 (Repeat)
> Testing ... (interrupt to exit)
> Event: time 38.740081, type 1 (Key), code 139 (Menu), value 1
> Event: time 38.740101, -------------- Report Sync ------------
> Event: time 38.850061, type 1 (Key), code 139 (Menu), value 0
> Event: time 38.850077, -------------- Report Sync ------------
>
> New version (updated platform definition to use struct matrix_keymap_=
data instead of max7359_keypad_platform_data):
>
> NCP:~# evtest /dev/input/event0
> Input driver version is 1.0.0
> Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
> Input device name: "max7359"
> Supported events:
> =A0Event type 0 (Sync)
> =A0Event type 1 (Key)
> =A0 =A0Event code 107 (End)
> =A0 =A0Event code 139 (Menu)
> =A0 =A0Event code 148 (Prog1)
> =A0 =A0Event code 149 (Prog2)
> =A0 =A0Event code 177 (ScrollUp)
> =A0 =A0Event code 178 (ScrollDown)
> =A0 =A0Event code 212 (Camera)
> =A0 =A0Event code 231 (?)
> =A0 =A0Event code 474 (?)
> =A0Event type 4 (Misc)
> =A0 =A0Event code 4 (ScanCode)
> =A0Event type 20 (Repeat)
> Testing ... (interrupt to exit)
> Event: time 75.680066, type 4 (Misc), code 4 (ScanCode), value 01
> Event: time 75.680095, type 1 (Key), code 139 (Menu), value 1
> Event: time 75.680107, -------------- Report Sync ------------
> Event: time 75.700072, type 4 (Misc), code 4 (ScanCode), value 3f
> Event: time 75.700095, -------------- Report Sync ------------
> Event: time 75.830064, type 4 (Misc), code 4 (ScanCode), value 01
> Event: time 75.830093, type 1 (Key), code 139 (Menu), value 0
> Event: time 75.830100, -------------- Report Sync ------------
> Event: time 75.850073, type 4 (Misc), code 4 (ScanCode), value 3f
> Event: time 75.850097, -------------- Report Sync ------------
>
> Something is definitely different. It looks that I missed a patch tha=
t added some additional events, because I don't think that the
> threaded irq patch would cause this.
>

Nope, it is not because of threaded irq patch but MSC_SCAN event
generation. Not to worry.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
