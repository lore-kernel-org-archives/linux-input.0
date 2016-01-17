From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: uinput: How to use force feedback?
Date: Sun, 17 Jan 2016 16:47:21 +0100
Message-ID: <CADbOyBSXuc1rUhG6g=Lt0t8FYvnsLdG_SE1smYdsAHdHv7d0zg@mail.gmail.com>
References: <n7g4s1$i1l$1@ger.gmane.org>
	<CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35006 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcAQPrW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jan 2016 10:47:22 -0500
Received: by mail-yk0-f178.google.com with SMTP id x67so592070026ykd.2
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2016 07:47:21 -0800 (PST)
In-Reply-To: <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sun, Jan 17, 2016 at 4:46 PM, Elias Vanderstuyft <elias.vds@gmail.com> wrote:
> On Sun, Jan 17, 2016 at 2:27 PM, Manuel Reimer
> <Manuel.Spam@nurfuerspam.de> wrote:
>> Hello,
>>
>> I have an existing uinput driver, which itself sits on an open device with a
>> blocking read(), waiting for events to come in. Every event is translated to
>> a key code and then sent to uinput.
>>
>> My next step would be to pass through force feedback information, but I
>> don't really understand how I should do this.
>
> Concerning this,
> the following may give you an example how to read incoming FF events on uinput:
> https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341
>
> A good while ago I started working on FF support for
> the uinput user-space library libsuinput, (and also for python-uinput,)
> but I have to clean up some things before I can merge it to:
> https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341

Sorry for the typo, here is the correct link:
https://github.com/tuomasjjrasanen/python-uinput/tree/master/libsuinput
