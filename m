From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: UHID Device Reports Do Not Generate OS Activity
Date: Sun, 11 Feb 2018 11:46:00 -0800
Message-ID: <CAEc3jaAyQiNDLbOvNkT65n-Vju-LOHjoSuiOqDunBFna0YDaBQ@mail.gmail.com>
References: <CAAD4mYj0pUUbwX8mKDP2qTn=QZM9ubk3f9FsabefK4xntY7bFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:46408 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeBKTqB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Feb 2018 14:46:01 -0500
In-Reply-To: <CAAD4mYj0pUUbwX8mKDP2qTn=QZM9ubk3f9FsabefK4xntY7bFA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: R0b0t1 <r030t1@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-usb@vger.kernel.org

It is hard to say what is wrong. I would start with reading the uhid /
hid code and see where you are getting stuck (and double check uhid
docs). Even for others we would need to do that as it is not easy to
see what is wrong.

I'm not sure what your goal is obvious you want to simulate a keyboard
for some purpose, but do you really need to operate at the HID layer?
If not it is much more convenient to use uinput, which will create a
evdev device for you.

Thanks,
Roderick

On Sat, Feb 10, 2018 at 1:33 AM, R0b0t1 <r030t1@gmail.com> wrote:
> Hello,
>
> I am trying to simulate a keyboard using the uhid interface. The fake
> device shows up in dmesg, but attempting to press the "a" key does
> nothing I can see. No input appears in the active terminal, nor in an
> xev window.
>
> The program receives UHID_OPEN, UHID_START, and UHID_CLOSE.
>
> Many different report descriptors were tried. The one currently
> uncommented is the one distributed with the USB implementor forum's
> HID report descriptor tool. The other is one found in a description of
> a boot device compatible keyboard.
>
> Thanks in advance,
>      R0b0t1
