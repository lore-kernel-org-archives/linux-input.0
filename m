From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 22/26] Input: synaptics-rmi4 - Add F30 support
Date: Tue, 10 Nov 2015 09:52:34 +0100
Message-ID: <CACRpkdanVfWWmkiVd_XHDE3cRFBxUQ4=GSXV+fK6iGeR9io8GQ@mail.gmail.com>
References: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
	<CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
	<CAN+gG=HGj4uvzCBwpEsot7qmxjeB8VyzDhYOwOYmDRQCogWtkg@mail.gmail.com>
	<56412410.4030900@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56412410.4030900@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Allie Xiong <axiong@synaptics.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 9, 2015 at 11:54 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> F30 is currently only used in touchpads and mostly used to report the the
> click of the tact switch on clickpads. When the GPIO interrupts we report
> the appropriate button event to the host. Because the GPIOs are wired to our
> ASIC and not to the host I'm not sure there is any benefit to exposing it to
> the host using gpio_chip.
>
> Dmitry asked a similar question and here is my response to him:
> http://www.spinics.net/lists/linux-input/msg40458.html

So I think this is basically a terminology problem. There are some lines
here that the firmware calls "GPIO" (GENERAL PURPOSE input/output)
but in practice it really doesn't mean that, right?

In practice this thing is not randomly connected to doorbells, relays,
I2C bitbanged buses or whatnot. It is connected to certain keys,
and it is used for input. So it is not GPIO at all, but special purpose
input. No output.

Then it should be contained totally inside the RMI4 driver and connect
directly to the input layer.

It doesn't matter if the Synaptics firmware and/or internal documentation
calls it GPIO, if it walks and talks and acts like a duck it is a duck.
So register an input device for it and dispatch input events and be
happy.

For LEDs it makes more sense to actually register with the LEDs
subsystem as it is clearly output-only.

Yours,
Linus Walleij
