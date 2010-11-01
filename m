From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: usb keyboard translations
Date: Mon, 1 Nov 2010 22:40:06 +0000
Message-ID: <AANLkTik+d8Ovxw64aPVj6zpnOY7njD8BdMa5zYXAcpe1@mail.gmail.com>
References: <AANLkTin9GHck97EdayM+iySpgPi3s0ZNuRYjqge16DOE@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697648C307F8A@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50782 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0KAWkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Nov 2010 18:40:07 -0400
Received: by vws13 with SMTP id 13so4168111vws.19
        for <linux-input@vger.kernel.org>; Mon, 01 Nov 2010 15:40:07 -0700 (PDT)
In-Reply-To: <0D753D10438DA54287A00B0270842697648C307F8A@AUSP01VMBX24.collaborationhost.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 1 November 2010 15:58, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Saturday, October 30, 2010 7:32 AM, James Courtier-Dutton wrote:
>> When I plug a special purpose keyboard into the USB port, it creates a
>> /dev/input/event9
>> It then provides input to the terminal as though it was a keyboard.
>> Unfortunately, the key mappings are all wrong for this keyboard.
>> Is there some way I can do key translations between the the USB
>> keyboard and the terminal.
>> The problem is I only want the translations to occur to events from
>> /dev/input/event9 and not any other keyboard/mouse device that is also
>> plugged in.
>> Alternatively, is there a way that I can get these events to not even
>> reach the terminal, and allow me to write a daemon that would listen
>> to /dev/input/event9 and provide a interface to my specific
>> application.
>
> Try sending ioctl EVIOCGRAB to the device after you open it in your daemon.
>

That was what I was looking for.

Thank you

James
