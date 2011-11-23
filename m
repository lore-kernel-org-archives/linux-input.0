From: simon@mungewell.org
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Wed, 23 Nov 2011 10:45:24 -0500
Message-ID: <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
References: <20111122102832.GA22152@v36691.1blu.de>
    <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
    <20111123084340.GA18805@tapura>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:55155 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab1KWPp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 10:45:26 -0500
In-Reply-To: <20111123084340.GA18805@tapura>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Andreas_H=FCbner=22?= <andreas@k4n.de>
Cc: linux-input@vger.kernel.org

Hi Andreas,

> I've attached the hid report descriptor in binary and spec format.

As you probably noticed this HID descriptor is a little 'weird'.

First it defines 6 usages
--
        Usage (X),                  ; X (30h, dynamic value)
        Usage (Y),                  ; Y (31h, dynamic value)
        Usage (Z),                  ; Z (32h, dynamic value)
        Usage (Rz),                 ; Rz (35h, dynamic value)
        Usage (Rx),                 ; Rx (33h, dynamic value)
        Usage (Slider),             ; Slider (36h, dynamic value)
--

but then only says they are 5 inputs
--
        Report Count (5),
--

I'm guessing that if you adjust the report count to '6' then your 6th axis
might start working, and possibly the hat-switch and buttons too...

So the next question has to be how committed to your ($15??) game pad are
you, and are you will to go through the pain of building/submitting
patches? It's a great opportunity to put 'kernel dev' on your resume ;-)


I'll have to defer to the other kernel devs....

Q. Is there a way of patching a HID descriptor without writing a driver?


Otherwise you could look at 'drivers/hid/hid-elecom.c' as a template for
your patch.

Good luck, and feel free to ask questions,
Simon.

