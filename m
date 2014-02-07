From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: PROBLEM: [Dell LATITUDE E7440] ALPS touchpad events are not
 routed into /dev/input/mice and /dev/input/mouseX
Date: Fri, 7 Feb 2014 08:46:08 -0800
Message-ID: <CAJiQ=7BgrY2aASfv0N4xx6TnZa1DSgvZdAzcg5XNYiMcpeFkjA@mail.gmail.com>
References: <CA+F6ckO02oxrgx3-9Fhu3XQFX_8WrUFL5_LTjA8-mUpZMy7QaQ@mail.gmail.com>
	<CABSveYhh-3WVnEUKDaYjdbTBQLwPJ1YnJ3toT0kxXd=9aECHyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:42158 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaBGQqK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Feb 2014 11:46:10 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so5516934qab.4
        for <linux-input@vger.kernel.org>; Fri, 07 Feb 2014 08:46:09 -0800 (PST)
In-Reply-To: <CABSveYhh-3WVnEUKDaYjdbTBQLwPJ1YnJ3toT0kxXd=9aECHyA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Titskiy <qehgt0@gmail.com>
Cc: Tommy Will <tommywill2011@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Feb 7, 2014 at 7:18 AM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> Hi Tommy,
>
> This is the output of `dmesg | grep -i 'input\|alps'` command after V5 enforced:
> [    1.592880] input: Lid Switch as
> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
> [    1.593928] input: Power Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
> [    1.593964] input: Sleep Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> [    1.593999] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    1.788587] input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input4
> [    2.661783] input: PS/2 Mouse as /devices/platform/i8042/serio1/input/input5
> [    2.674857] input: AlpsPS/2 ALPS GlidePoint as
> /devices/platform/i8042/serio1/input/input6

Could you confirm that you're seeing actual ALPS V5 absolute reports
with the patched driver, not just emulated PS/2 mouse reports?

Do edge scrolling and multitouch work correctly on the patched driver?

> ...and before my patch (current kernel behavior):
> [    1.604029] input: Lid Switch as
> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
> [    1.606813] input: Power Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
> [    1.608991] input: Sleep Button as
> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> [    1.610997] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    3.636959] input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input4
> [    8.377859] input: DualPoint Stick as
> /devices/platform/i8042/serio1/input/input5
> [    8.542194] input: AlpsPS/2 ALPS DualPoint TouchPad as
> /devices/platform/i8042/serio1/input/input6

This laptop does have a trackstick, correct?

(I see it on the Dell spec sheet but I'd like to confirm your unit has it.)

Thanks.
