From: Denis Akiyakov <d.akiyakov@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Thu, 23 Oct 2014 11:54:21 +0700
Message-ID: <544889FD.5030004@gmail.com>
References: <54424770.9090600@gmail.com> <20141021223311.GG8609@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:54222 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaJWEzd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 00:55:33 -0400
Received: by mail-lb0-f193.google.com with SMTP id l4so119420lbv.0
        for <linux-input@vger.kernel.org>; Wed, 22 Oct 2014 21:55:31 -0700 (PDT)
In-Reply-To: <20141021223311.GG8609@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans Petter Selasky <hps@selasky.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

On 22.10.2014 05:33, Dmitry Torokhov wrote:
> Hi Denis,
>
> On Sat, Oct 18, 2014 at 05:56:48PM +0700, Denis Akiyakov wrote:
>> Hello,
>>
>> I'm using FreeBSD 10.1 and FreeBSD use webcamd witch contain linux
>> wacom driver to provide wacom tablets support. More info here:
>> http://www.selasky.org/hans_petter/video4bsd/ or
>> http://www.freshports.org/multimedia/webcamd/
>>
>> I've got latest version of webcamd and Wacom device CTH680, but
>> device isn't working correct.
> Have you tried the device with Linux instead of FreeBSD? If it works in
> Linux that means that the port of linux drivers to BSD is to blame and
> you need to contact its authors, otherwise we need to adjust wacom
> driver in kernel for this device.
>
> Thanks.
>
Hello, Dmitry.

I've tried tablet in Ubuntu 14.04.1. All functions that work in Windows 
7 (in Krita) work under Ubuntu's Krita.

Thank you for your attention.
