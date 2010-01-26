From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: gpio_keys and how PXA27x sets gpio_set_wake() (was Re: sharp
	c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1)
Date: Tue, 26 Jan 2010 14:23:56 +0300
Message-ID: <bc64b4641001260323y496bf7cdv507085644fadb0fe@mail.gmail.com>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<1264275669.9100.11.camel@utx.utx.cz>
	<1264286611.11766.49.camel@utx.utx.cz>
	<f17812d71001251958t377e158bxc64aac0cb426110b@mail.gmail.com>
	<1264500824.4480.79.camel@utx.utx.cz>
	<f17812d71001260220v5d03b0e1u1e3bc229827c37c8@mail.gmail.com>
	<1264502668.4480.97.camel@utx.utx.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1264502668.4480.97.camel@utx.utx.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stanislav Brabec <utx@penguin.cz>
Cc: Andrew Morton <akpm@osdl.org>, thommycheck <thommycheck@gmail.com>, dtor <dtor@mail.ru>, arminlitzel <arminlitzel@web.de>, kernel list <linux-kernel@vger.kernel.org>, Cyril Hrubis <metan@ucw.cz>, Dirk <Dirk@opfer-online.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, lenz <lenz@cs.wisc.edu>, Vojtech Pavlik <vojtech@suse.cz>, rpurdie <rpurdie@rpsys.net>, omegamoon <omegamoon@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-input <linux-input@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, zaurus-devel <zaurus-devel@lists.linuxtogo.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hello,

2010/1/26 Stanislav Brabec <utx@penguin.cz>:
> Eric Miao wrote:
>> > The problem affects gpio_keys: It is a driver implementing "one key per
>> > gpio". It now handles On/Off and lid switches on Zaurus. Lid switches
>> > are on "normal" GPIOs, On/Off switch is wired to PKWR capable GPIO.
>> Ain't On/Off switch one of the matrix key? And so SPITZ_GPIO_KEY_INT
>> could be used to handle that?
>
> No. On/Off is connected directly to GPIO 95. Other keys use strobe/sense
> matrix keypad.
>
> SPITZ_GPIO_KEY_INT is a bit unspecific. I think it means: Charger was
> inserted or key was pressed or On/Off was pressed.

This seems to be true. At least they used the same design on tosa and other
zaurii.


-- 
With best wishes
Dmitry
