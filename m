From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Fri, 31 Oct 2014 16:27:33 -0700
Message-ID: <CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
References: <54424770.9090600@gmail.com>
	<20141021223311.GG8609@dtor-ws>
	<544889FD.5030004@gmail.com>
	<54489803.9030803@selasky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:62583 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaJaX1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 19:27:35 -0400
Received: by mail-la0-f51.google.com with SMTP id q1so7041059lam.38
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 16:27:34 -0700 (PDT)
In-Reply-To: <54489803.9030803@selasky.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans Petter Selasky <hps@selasky.org>
Cc: Denis Akiyakov <d.akiyakov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

Hi Hans,

On Wed, Oct 22, 2014 at 10:54 PM, Hans Petter Selasky <hps@selasky.org> wrote:
>
> On 10/23/14 06:54, Denis Akiyakov wrote:
>>
>> On 22.10.2014 05:33, Dmitry Torokhov wrote:
>>>
>>> Hi Denis,
>>>
>>> On Sat, Oct 18, 2014 at 05:56:48PM +0700, Denis Akiyakov wrote:
>>>>
>>>> Hello,
>>>>
>>>> I'm using FreeBSD 10.1 and FreeBSD use webcamd witch contain linux
>>>> wacom driver to provide wacom tablets support. More info here:
>>>> http://www.selasky.org/hans_petter/video4bsd/ or
>>>> http://www.freshports.org/multimedia/webcamd/
>>>>
>>>> I've got latest version of webcamd and Wacom device CTH680, but
>>>> device isn't working correct.
>>>
>>> Have you tried the device with Linux instead of FreeBSD? If it works in
>>> Linux that means that the port of linux drivers to BSD is to blame and
>>> you need to contact its authors, otherwise we need to adjust wacom
>>> driver in kernel for this device.
>>>
>>> Thanks.
>>>
>> Hello, Dmitry.
>>
>> I've tried tablet in Ubuntu 14.04.1. All functions that work in Windows
>> 7 (in Krita) work under Ubuntu's Krita.
>>
>> Thank you for your attention.
>>
>
> Hi,
>
> The problem appears to be that webcamd launches two instances for each interface, so the shared data is not the same like with Linux. Actually the shared data is NULL.

If shared is NULL on FreeBSD, you need to make sure that part of code
is portable on FreeBSD. On Linux, the driver would fail to load if
shared is NULL since at least the current data can be assigned to
wacom_shared (please refer to wacom_add_shared_data() in wacom_sys.c
for detail).

> I think however it would be clever that the Linux Wacom code would check "wacom->shared->touch_input" for NULL before using it, because it is not always set. This can be an easy way to crash the kernel when plugging a USB devices.
>
> drivers/hid/wacom_wac.c:1395

touch_input is used in 6 places (4 times in wacom_wac.c and 2 times in
wacom_sys.c). They are called only when touch_max is not zero, that
is, only when touch input is defined.

If touch_input is NULL on FreeBSD, you need to figure out the root
cause. Checking on touch_input itself would not fix the root cause...

We are here to help if there is anything unclear to you in the code.

Cheers,

Ping
