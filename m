From: "Simon Wood" <simon@mungewell.org>
Subject: Re: Logitech Precision Gamepad shows axis activity upon connection
Date: Tue, 13 Sep 2016 10:36:27 -0600
Message-ID: <8a180a033d3f0224efb3658d37443015.squirrel@mungewell.org>
References: <CAPAjh3dvRNm_U1Ax41NwUA5rM-PYA+SUxZ5HUxu3Da6919YJCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:52318 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbcIMQgd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 12:36:33 -0400
In-Reply-To: <CAPAjh3dvRNm_U1Ax41NwUA5rM-PYA+SUxZ5HUxu3Da6919YJCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eddie Stanley <eddie@eddiewould.com>
Cc: linux-input@vger.kernel.org, gregkh@linuxfoundation.org

On Tue, September 13, 2016 2:26 am, Eddie Stanley wrote:
> SUMMARY:
> Logitech Precision Gamepad shows axis activity upon connection
>
>
> DESCRIPTION:
> When I connect my Logitech Precision Gamepad (or the machine starts up
> with it connected) it exhibits activity on both axes until I press a
> button/press the d-pad.

Hi Eddie,
No solution(s) for you but what I think you are seeing is default values
in the HID system, until the device actually sends some data. Don't know
if you can prompt it to send a frame to get sync'ed.

BTW the incoming frames can be seen on the 'hidraw' device with something
like (adjust '8' to number of bytes your device sends).
--
root@retrobox:/home/simon# hexdump -v -e '8/1 "%02x " "\n"' < /dev/hidraw0
08 00 00 5e 8a 32 cd 99
08 00 00 5e 8a 32 cd 99
--


> Note - I'm not sure whether the d-pad should be classified as a pair of
> axes or a pair of hats - it is a digital d-pad though, *not* analog.

There has always been debate on this, it boils down to how the device is
described in the HID descriptor. Either a HAT (with null position) or a
D-PAD. Linux treats HATs 2 axis joystick.

You can use 'hidrd' to decode the descriptor (from
'/sys/bus/hid/devices/<device>/descriptor') to confirm what it reports.

I have a Logitech game pad which does the same, the HID descriptor contains
--
Logical Maximum (7),
Physical Maximum (315),
Report Size (4),
Report Count (1),
Unit (Degrees),
Usage (Hat Switch), ; Hat switch (39h, dynamic value)
Input (Variable, Null State),
Unit,
--

A possible work around is described here:
http://hans.fugal.net/blog/2007/06/02/joystick-hat-in-x-plane-in-linux/

Cheers,
Simon.


