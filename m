From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: PROBLEM: [Dell LATITUDE E7440] ALPS touchpad events are not
 routed into /dev/input/mice and /dev/input/mouseX
Date: Fri, 7 Feb 2014 10:18:32 -0500
Message-ID: <CABSveYhh-3WVnEUKDaYjdbTBQLwPJ1YnJ3toT0kxXd=9aECHyA@mail.gmail.com>
References: <CA+F6ckO02oxrgx3-9Fhu3XQFX_8WrUFL5_LTjA8-mUpZMy7QaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:42455 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbaBGPSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Feb 2014 10:18:54 -0500
Received: by mail-ee0-f52.google.com with SMTP id e53so1587832eek.25
        for <linux-input@vger.kernel.org>; Fri, 07 Feb 2014 07:18:53 -0800 (PST)
In-Reply-To: <CA+F6ckO02oxrgx3-9Fhu3XQFX_8WrUFL5_LTjA8-mUpZMy7QaQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Tommy,

This is the output of `dmesg | grep -i 'input\|alps'` command after V5 enforced:
[    1.592880] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    1.593928] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    1.593964] input: Sleep Button as
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    1.593999] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.788587] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    2.661783] input: PS/2 Mouse as /devices/platform/i8042/serio1/input/input5
[    2.674857] input: AlpsPS/2 ALPS GlidePoint as
/devices/platform/i8042/serio1/input/input6

...and before my patch (current kernel behavior):
[    1.604029] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    1.606813] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    1.608991] input: Sleep Button as
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    1.610997] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    3.636959] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    8.377859] input: DualPoint Stick as
/devices/platform/i8042/serio1/input/input5
[    8.542194] input: AlpsPS/2 ALPS DualPoint TouchPad as
/devices/platform/i8042/serio1/input/input6

  Vasily Titskiy


On Fri, Feb 7, 2014 at 3:18 AM, Tommy Will <tommywill2011@gmail.com> wrote:
> Hi Vasily,
>
> Thanks for your mail & information. We would start the investigation
> and give you feedback later.
> Please wait.
>
>> The issues occurs on every kernel after
>> 1302bac33d9e88cd43e482191a806998f3ed43cc commit. Before the commit, this touchpad device was detected as PS/2 mouse and "cat /dev/input/mice" shows data when the touchpad is used.
>> After the commit, there are no events from the touchpad in /dev/input/mice or /dev/input/mouseX files anymore.
>>
>> According to drivers/input/mouse/alps.c source file, all devices with signatures "ec[0] == 0x88 && ec[1] == 0x08" are treated as "Rushmore touchpads". This touchpad has E7 signature of "73-03-0A" and EC signature of "88-08-22", and it looks like that V5 protocol (not
>> "Rushmore") should be used here. If V5 protocol is forced to use for this device then everything works fine.
>>
>> The patch is trivial, but I'm not sure how to properly separate "Rushmore" and "V5" devices. Are there any datasheets or experts to help me with it?
>>
>
> I checked the E7 & EC information and think it should be a Rushmore device.
> Could you please let me know after you use V5 protocol, if touchpad
> still be recognized as "AlpsPS/2 ALPS DualPoint TouchPad" or returns
> to "PS/2 Generic Mouse" ?
>
> Thanks
> --
> Best Regards,
> Tommy
