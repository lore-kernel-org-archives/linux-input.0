From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: uinput on headless system ...
Date: Thu, 14 Jan 2016 06:08:53 +0100
Message-ID: <CAN+gG=FirVq_MrXDkFe8K=7TEVzif9MSHvov4SyZE1M_Z5N=8g@mail.gmail.com>
References: <56965CFB.3020401@icid.cu>
	<20160113222151.GE39593@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38098 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbcANFIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 00:08:55 -0500
Received: by mail-wm0-f45.google.com with SMTP id b14so406885016wmb.1
        for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 21:08:54 -0800 (PST)
In-Reply-To: <20160113222151.GE39593@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roberto Alejandro Espi Munoz <raespi@icid.cu>, linux-input <linux-input@vger.kernel.org>

Hi Roberto,

On Wed, Jan 13, 2016 at 11:21 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Roberto,
>
> On Wed, Jan 13, 2016 at 09:19:39AM -0500, Roberto Alejandro Espi Munoz wrote:
>> Hello ... I've been searching around the web for a specific mailing
>> list for the uinput driver but couldn't find any.  I managed to
>> create an example app that injects keyboard events to the running
>> linux kernel succesfully when I have a keyboard attached to the
>> computer.  However if I run it on a keyboardless machine, like a
>> standalone motherboard, the uinput device fails to open.
>
> uinput driver does not depend on presence of a physical keyboard. I'd
> start looking whether uinput module is enabled on your headless box and
> if it is a module verify that it is loaded.
>

As Dmitry said, uinput is independent of any attached hardware.
You might want to see how we managed to create new devices through
uinput by looking at libevdev[1] (see libevdev/libevdev-uinput.c).

You might actually also want to use libevdev instead of manually doing
the ioctls and processing of all the small things :)

Cheers,
Benjamin

[1] http://www.freedesktop.org/wiki/Software/libevdev/
