From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - Add shutdown callback
Date: Tue, 5 Feb 2019 16:45:29 -0800
Message-ID: <20190206004529.GC19151@dtor-ws>
References: <20190201192417.15037-1-f.fainelli@gmail.com>
 <65d6350f-2cd8-c183-6d8b-dbb11ae31819@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <65d6350f-2cd8-c183-6d8b-dbb11ae31819@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 05, 2019 at 02:02:49PM -0800, Florian Fainelli wrote:
> On 2/1/19 11:24 AM, Florian Fainelli wrote:
> > On some platforms (e.g.: ARCH_BRCMSTB) it is possible to enter
> > "poweroff" while leaving some wake-up sources enabled such as key
> > presses in order to allow for the system to wake-up.
> > 
> > Wire up a .shutdown() callback which calls into the existing
> > gpio_keys_suspend() since the logic is essentially the same.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Any feedback on this?

OK, I'll take it. Hopefully it won't affect existing systems as the
change is unconditional.

Thanks.

-- 
Dmitry
