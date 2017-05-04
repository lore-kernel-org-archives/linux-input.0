From: Tomohiro Yoshidomi <sylph23k@gmail.com>
Subject: Re: [PATCH v7] Input: psxpad-spi - Add PlayStation 1/2 joypads via
 SPI interface Driver
Date: Fri, 5 May 2017 00:09:20 +0900
Message-ID: <CAGeZN5Pysq=q3Pcwbx0r2J=gOsgE4coX=8rM+_MBtJZogJxOTw@mail.gmail.com>
References: <20170430051103.703-1-sylph23k@gmail.com> <20170501194708.GD34444@dtor-ws>
 <CANq1E4SzKF__70ixZnOeEB__wqZy7ghWRAsx3m36TiOMysEgkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33648 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbdEDPJW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 11:09:22 -0400
In-Reply-To: <CANq1E4SzKF__70ixZnOeEB__wqZy7ghWRAsx3m36TiOMysEgkw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomohiro Yoshidomi <typesylph@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Mr.Torokhov
Mr.Herrmann

> The FF code could be select'ed rather than conditional.

Sorry, I can't understand mean well. How I to do...?

I should to fix,

In 'config JOYSTICK_PSXPAD_SPI',
change 'select INPUT_POLLDEV' to
'select INPUT_POLLDEV
select INPUT_FF_MEMLESS'.

And

In 'config JOYSTICK_PSXPAD_SPI_FF',
remove 'select INPUT_FF_MEMLESS'.

...Can I understand in the sense?

Regard.


2017-05-03 20:14 GMT+09:00 David Herrmann <dh.herrmann@gmail.com>:
> Hey
>
> On Mon, May 1, 2017 at 9:47 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Sun, Apr 30, 2017 at 02:11:03PM +0900, Tomohiro Yoshidomi wrote:
>>> PlayStation 1/2 joypads can be connected directly to the SPI interface.
>>>
>>> Signed-off-by: Tomohiro Yoshidomi <sylph23k@gmail.com>
>>
>> Benjamin, David, I think this driver now matches the gamepad spec that
>> we have in Drivers/input/gamepad.rst. Could you give it an one-over, as
>> far as mappings go, otherwise I think it can be applied and merged with
>> my 2nd pull request.
>
> Looks good to me:
>
> Acked-by: David Herrmann <dh.herrmann@gmail.com>
>
> The FF code could be select'ed rather than conditional. Everything
> else looks fine. I didn't check the SPI internals though. Never
> touched SPI, sorry.
>
> Thanks
> David
