From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Wed, 1 Feb 2017 15:51:06 +0100
Message-ID: <CACRpkdaO=1+JHs2qtVULyN1B1pfajc=UF-V_N+Ej_i5SMv-pPQ@mail.gmail.com>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170131010607.GC35974@dtor-ws> <20170131090432.72a1b1b8@bbrezillon>
 <20170131084447.GD8311@dtor-ws> <20170131100721.22c2388d@bbrezillon>
 <20170131091155.GH8311@dtor-ws> <20170131102424.7b68c0d4@bbrezillon>
 <20170131183936.GB13642@dtor-ws> <20170131204202.7b589ca6@bbrezillon>
 <CACRpkdbr6BGm3mJ_2XOAuootK-ruibiGsG8=LvKhrz1cpUrnhA@mail.gmail.com> <20170201142228.053e2041@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170201142228.053e2041@bbrezillon>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 1, 2017 at 2:22 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Wed, 1 Feb 2017 14:05:43 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:

>> > Linus, is this something you really care about? If that's the case, can
>> > you step in?
>>
>> I can only throw up my hands...
>
> Sorry for forcing your hand like this, but this is the kind of
> discussion I'm not comfortable with (when I need to argue on something
> I'm not completely convinced of, or I don't have opinion on).

Sorry, I'm just too stressed by all patches. I now read back on the
context below.

>> The way I percieved it, a new function
>> was added, but I guess it could be that the diffstat was so
>> convoluted in the other patch (by the way that diff sometimes give
>> very confusing stuff unless you use the right fuzz) so I misunderstood
>> some other renaming as introducing a new function.
>
> Indeed, a new function is added (see patch 2), and this new function is
> taking an additional 'index' parameter. If that's a problem, I can also
> change the prototype of devm_get_gpiod_from_child() and patch all
> existing users of this function, but I fear we'll end up with pretty
> much the same discussion :-/.

Yeah.

>> Please drop the patch if it is controversial.
>>
>> The name of the function *is* confusing though but maybe it's not
>> the biggest problem in the world.
>
> I can still name the new function as you suggested
> (devm_fwnode_get_index_gpiod_from_child()), and keep the existing one
> unchanged if you want.

But that is just insane. Then it is just better to apply this and the
other patch making the situation manageable.

This is a good time to do it too since I'm anyways patching around
in all the consumers this merge window.

Dmitry: is this such a big deal to you?

commit 40b7318319281b1bdec804f6435f26cadd329c13
"gpio: Support for unified device properties interface"

by Mika Westerberg introduced

fwnode_get_named_gpiod()
devm_get_gpiod_from_child()

Both are taking a fwnode as argument and the naming is as
inconsistent as it can be.

Some more churn should be expected as a side
effect of naming this function wrong in the first place.
The fwnode API change was on fast-forward and mistakes
were made, also by me, mea culpa.

When I write kernel code, I usually intuitively look for a function doing
what I want, this naming is unintuitive, and it has confused me so
it will confuse others.

Can I please apply these two patches?

Yours,
Linus Walleij
