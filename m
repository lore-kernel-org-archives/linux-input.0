From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: uinput: How to use force feedback?
Date: Sun, 17 Jan 2016 16:46:13 +0100
Message-ID: <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
References: <n7g4s1$i1l$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36267 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcAQPqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jan 2016 10:46:13 -0500
Received: by mail-yk0-f176.google.com with SMTP id v14so496653943ykd.3
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2016 07:46:13 -0800 (PST)
In-Reply-To: <n7g4s1$i1l$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sun, Jan 17, 2016 at 2:27 PM, Manuel Reimer
<Manuel.Spam@nurfuerspam.de> wrote:
> Hello,
>
> I have an existing uinput driver, which itself sits on an open device with a
> blocking read(), waiting for events to come in. Every event is translated to
> a key code and then sent to uinput.
>
> My next step would be to pass through force feedback information, but I
> don't really understand how I should do this.

Concerning this,
the following may give you an example how to read incoming FF events on uinput:
https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341

A good while ago I started working on FF support for
the uinput user-space library libsuinput, (and also for python-uinput,)
but I have to clean up some things before I can merge it to:
https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341

Thanks,
Elias
