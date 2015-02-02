From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Mon, 2 Feb 2015 10:42:29 -0500
Message-ID: <CAN+gG=FOTiX+VXM1F49jrhnCM1uZt7Vv=Rr6W2mTHYuX+rKjPw@mail.gmail.com>
References: <54CCEE3D.9040306@m-labs.hk>
	<CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
	<54CD9D0D.20402@m-labs.hk>
	<20150202100031.GP22740@lahna.fi.intel.com>
	<54CF7977.1090105@m-labs.hk>
	<20150202134805.GT22740@lahna.fi.intel.com>
	<54CF9883.10701@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43411 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbBBPma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 10:42:30 -0500
Received: by mail-qg0-f50.google.com with SMTP id f51so47943530qge.9
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2015 07:42:29 -0800 (PST)
In-Reply-To: <54CF9883.10701@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?S=C3=A9bastien_Bourdeauducq?= <sb@m-labs.hk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Feb 2, 2015 at 10:32 AM, S=C3=A9bastien Bourdeauducq <sb@m-labs=
=2Ehk> wrote:
> On 02/02/2015 09:48 PM, Mika Westerberg wrote:
>> On Mon, Feb 02, 2015 at 09:19:51PM +0800, Sebastien Bourdeauducq wro=
te:
>>> With this computer nothing is normal. Every single component except=
 the CPU,
>>> display and USB has major issues under Linux.
>>
>> We need to get one here then. Can you point me to the exact model?
>
> That's a Lenovo Thinkpad Tablet 10, P/N 20C3001VHH. What would be the
> plan for you to get one?
>
>> Since it has 20k internal pull-up configured, I'm guessing something
>> (the digitizer) drives it low like it still has something to report.=
 Do
>> you see in the dmesg if the i2c-hid.c is able to read reports from t=
he
>> device?
>
> When I made the interrupt falling edge sensitive, i2c-hid was able to
> read the first report as I could move the mouse cursor once using the
> stylus.
>
> A possible scenario is:
> 1) the digitizer is holding the interrupt line low after booting
> 2) enumerating or otherwise initializing the digitizer causes it to
> release the interrupt line
> 3) using the stylus queues several reports in the device and it asser=
ts
> the interrupt line again. However, with the interrupt configured as e=
dge
> sensitive, only the first of those reports are retrieved and subseque=
nt
> ones are lost, with the interrupt line stuck.

There has been a patch floating around last year which tried to pull
all the available reports after the IRQ was triggered. I rejected it
for the sake of not breaking existing devices, but maybe your device
needs it.
http://www.spinics.net/lists/linux-input/msg31342.html

Cheers,
Benjamin

>
> Maybe the interrupt should be level sensitive and enabled only after
> certain parts of the device initialization have taken place.
>
> S=C3=A9bastien
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
