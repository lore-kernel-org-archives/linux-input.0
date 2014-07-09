From: Michael Wright <michaelwr@android.com>
Subject: Re: PS3 controller and vibration
Date: Wed, 9 Jul 2014 12:47:59 -0700
Message-ID: <CALDEARhCi+0TidoTmsDoYEnVUedCc-1m2AnLypkimJbkJfWaYQ@mail.gmail.com>
References: <lpk5ru$5ak$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33908 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaGITsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 15:48:19 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so1595332obc.6
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 12:48:19 -0700 (PDT)
In-Reply-To: <lpk5ru$5ak$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: andrea <mariofutire@googlemail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Check to see if it says DUALSHOCK 3 on the top. Regular SIXAXIS
controllers don't support force feedback.


On Wed, Jul 9, 2014 at 12:40 PM, andrea <mariofutire@googlemail.com> wrote:
>
> Hi,
>
> I've got a PS3 controller (sixaxis written on the back)
>
> PLAYSTATION(R)3 Controller as
> /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:72/0005:054C:0268.0002/input/input10
> BLUETOOTH HID v1.00 Joystick [PLAYSTATION(R)3 Controller] on 00:1a:7d:da:71:0b
>
> using bluez 5.18 on Fedora 20, kernel 3.15.3
>
> it is connected via bluetooth.
>
> It does not vibrate.
> I've tried to write to /dev/hidraw0 and used love2d.
>
> I read online either than I need to enable the vibration or that the sixaxis does not support it.
> I am pretty sure it has vibrated on some games on the PS3.
>
> Does anybody know how it works?
>
> Andrea
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
