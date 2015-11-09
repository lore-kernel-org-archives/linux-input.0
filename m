From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 22/26] Input: synaptics-rmi4 - Add F30 support
Date: Mon, 9 Nov 2015 15:25:57 -0800
Message-ID: <20151109232557.GG9155@dtor-ws>
References: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
 <CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
 <CAN+gG=HGj4uvzCBwpEsot7qmxjeB8VyzDhYOwOYmDRQCogWtkg@mail.gmail.com>
 <56412410.4030900@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56412410.4030900@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Allie Xiong <axiong@synaptics.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 09, 2015 at 02:54:08PM -0800, Andrew Duggan wrote:
> On 11/09/2015 06:06 AM, Benjamin Tissoires wrote:
> >Hey Linus,
> >
> >first thanks for the reviews. Much appreciated.
> >
> >On Mon, Nov 9, 2015 at 2:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >>On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
> >>
> >>>From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>>
> >>>RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
> >>>buttons.  In particular, the mechanical button support is used in
> >>>an increasing number of touchpads.
> >>>
> >>>[BT] cured the code to rely only on the unified input node created
> >>>by rmi_driver.
> >>>
> >>>Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> >>>Signed-off-by: Allie Xiong <axiong@synaptics.com>
> >>>Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>I see this function driver is not yet adding any gpio_chip or
> >>LEDs class devices, which is fine, we can add that later when
> >>we have something to test. Or is iit using that LED feature
> >>in the input layer that corresponds to caps lock etc?
> 
> F30 is currently only used in touchpads and mostly used to report
> the the click of the tact switch on clickpads. When the GPIO
> interrupts we report the appropriate button event to the host.
> Because the GPIOs are wired to our ASIC and not to the host I'm not
> sure there is any benefit to exposing it to the host using
> gpio_chip.
> 
> Dmitry asked a similar question and here is my response to him:
> http://www.spinics.net/lists/linux-input/msg40458.html
> 
> There are a few rmi touchpads which have LEDs in the top left corner
> to indicate if the touchpad has been enabled / disabled. Writing to
> a register in F30 would turn on and off the LED. I don't think they
> are being made anymore so I haven't really looked into how we would
> implement this. If there is something in the input layer for
> controlling LEDs that might be the way to do it.

No, it should be eventually exported as a generic LED (input core itself
now registers its capslock, etc leds with LED core and I do not plan on
adding new input LEDs).

> 
> >Do not take my words as the official ones, but when we discussed with
> >Synaptics about F30 (and unified input), they told us that they
> >designed the driver based on the phone use case. In such use case, the
> >power (and maybe LEDs) are handled through F30, and the touchscreen
> >through F11/12. Problem is, I am not even sure there are phones around
> >with such F30/F11 combination.
> >
> >So in the end, from what I can see, F30 is used for buttons on
> >touchpads/clickpads, and LEDs when there are some on these touchpads.
> >
> >I don't know if the keyboards would use F30 for their LEDs though.
> >
> >That being said. Unless Synaptics tells us that there are uses of a
> >non "unified" input device somewhere, I would also agree to only keep
> >the "unified" input node, which would simplify both F11/12 and F30.
> 
> The original architecture of the driver was to have each function
> have it's own input device. The reasoning was that you would have a
> phone with a touchscreen (F11) and maybe some capacitive buttons
> (F19 or F1A or something) and that the system should see these as
> two separate devices. I'm wondering if this is needed though. Would
> userspace care if a touchscreen also reported KEY_HOME, KEY_BACK, or
> KEY_MENU?
> 
> At this point I agree, it's probably time to just have F11, F12, and
> F30 all report from the input device created in rmi_driver and
> remove the non unified option. If someday there is a function which
> needs to report data from a different input device it can just
> create it in that function.

Hmm.. if F30 is used for clickpads I agree that we'd want to mix it in
with the F11 data. But for generic capacitive buttons I think it would
be better if they are reported separately. Whether we want to do that
form F30 or have F30 actually export gpios and use gpio-keys to actually
create input device - I am open to discussing.

Thanks.

-- 
Dmitry
