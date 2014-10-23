From: Hans Petter Selasky <hps@selasky.org>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Thu, 23 Oct 2014 07:54:11 +0200
Message-ID: <54489803.9030803@selasky.org>
References: <54424770.9090600@gmail.com> <20141021223311.GG8609@dtor-ws> <544889FD.5030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from heidi.turbocat.net ([88.198.202.214]:38356 "EHLO
	mail.turbocat.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaJWGCo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 02:02:44 -0400
In-Reply-To: <544889FD.5030004@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Akiyakov <d.akiyakov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

On 10/23/14 06:54, Denis Akiyakov wrote:
> On 22.10.2014 05:33, Dmitry Torokhov wrote:
>> Hi Denis,
>>
>> On Sat, Oct 18, 2014 at 05:56:48PM +0700, Denis Akiyakov wrote:
>>> Hello,
>>>
>>> I'm using FreeBSD 10.1 and FreeBSD use webcamd witch contain linux
>>> wacom driver to provide wacom tablets support. More info here:
>>> http://www.selasky.org/hans_petter/video4bsd/ or
>>> http://www.freshports.org/multimedia/webcamd/
>>>
>>> I've got latest version of webcamd and Wacom device CTH680, but
>>> device isn't working correct.
>> Have you tried the device with Linux instead of FreeBSD? If it works in
>> Linux that means that the port of linux drivers to BSD is to blame and
>> you need to contact its authors, otherwise we need to adjust wacom
>> driver in kernel for this device.
>>
>> Thanks.
>>
> Hello, Dmitry.
>
> I've tried tablet in Ubuntu 14.04.1. All functions that work in Windows
> 7 (in Krita) work under Ubuntu's Krita.
>
> Thank you for your attention.
>

Hi,

The problem appears to be that webcamd launches two instances for each 
interface, so the shared data is not the same like with Linux. Actually 
the shared data is NULL.

I think however it would be clever that the Linux Wacom code would check 
"wacom->shared->touch_input" for NULL before using it, because it is not 
always set. This can be an easy way to crash the kernel when plugging a 
USB devices.

drivers/hid/wacom_wac.c:1395

and some more places.

--HPS
