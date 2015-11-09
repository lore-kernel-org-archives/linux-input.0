From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 22/26] Input: synaptics-rmi4 - Add F30 support
Date: Mon, 9 Nov 2015 15:06:27 +0100
Message-ID: <CAN+gG=HGj4uvzCBwpEsot7qmxjeB8VyzDhYOwOYmDRQCogWtkg@mail.gmail.com>
References: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
	<CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Allie Xiong <axiong@synaptics.com>
List-Id: linux-input@vger.kernel.org

Hey Linus,

first thanks for the reviews. Much appreciated.

On Mon, Nov 9, 2015 at 2:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
>
>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
>> buttons.  In particular, the mechanical button support is used in
>> an increasing number of touchpads.
>>
>> [BT] cured the code to rely only on the unified input node created
>> by rmi_driver.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Signed-off-by: Allie Xiong <axiong@synaptics.com>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> I see this function driver is not yet adding any gpio_chip or
> LEDs class devices, which is fine, we can add that later when
> we have something to test. Or is iit using that LED feature
> in the input layer that corresponds to caps lock etc?

Do not take my words as the official ones, but when we discussed with
Synaptics about F30 (and unified input), they told us that they
designed the driver based on the phone use case. In such use case, the
power (and maybe LEDs) are handled through F30, and the touchscreen
through F11/12. Problem is, I am not even sure there are phones around
with such F30/F11 combination.

So in the end, from what I can see, F30 is used for buttons on
touchpads/clickpads, and LEDs when there are some on these touchpads.

I don't know if the keyboards would use F30 for their LEDs though.

That being said. Unless Synaptics tells us that there are uses of a
non "unified" input device somewhere, I would also agree to only keep
the "unified" input node, which would simplify both F11/12 and F30.

>
> I don't quite get it I guess :/
>
> But I guess it should also be squashed into the original F30 driver.

I think this is the original F30 driver :-)

Cheers,
Benjamin
