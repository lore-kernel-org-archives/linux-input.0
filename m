From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v7] Input: psxpad-spi - Add PlayStation 1/2 joypads via
 SPI interface Driver
Date: Wed, 3 May 2017 13:14:47 +0200
Message-ID: <CANq1E4SzKF__70ixZnOeEB__wqZy7ghWRAsx3m36TiOMysEgkw@mail.gmail.com>
References: <20170430051103.703-1-sylph23k@gmail.com> <20170501194708.GD34444@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35831 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdECLOs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 May 2017 07:14:48 -0400
In-Reply-To: <20170501194708.GD34444@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tomohiro Yoshidomi <typesylph@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, sylph23k@gmail.com

Hey

On Mon, May 1, 2017 at 9:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Apr 30, 2017 at 02:11:03PM +0900, Tomohiro Yoshidomi wrote:
>> PlayStation 1/2 joypads can be connected directly to the SPI interface.
>>
>> Signed-off-by: Tomohiro Yoshidomi <sylph23k@gmail.com>
>
> Benjamin, David, I think this driver now matches the gamepad spec that
> we have in Drivers/input/gamepad.rst. Could you give it an one-over, as
> far as mappings go, otherwise I think it can be applied and merged with
> my 2nd pull request.

Looks good to me:

Acked-by: David Herrmann <dh.herrmann@gmail.com>

The FF code could be select'ed rather than conditional. Everything
else looks fine. I didn't check the SPI internals though. Never
touched SPI, sorry.

Thanks
David
