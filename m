From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Date: Thu, 23 Aug 2012 19:12:04 +0200
Message-ID: <50366464.4070801@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit.thebaudeau@advansee.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/23/2012 06:57 PM, Beno=C3=AEt Th=C3=A9baudeau wrote:
> On Thursday, August 23, 2012 5:43:32 PM, Lars-Peter Clausen wrote:
>> On 08/23/2012 04:19 PM, Beno=C3=AEt Th=C3=A9baudeau wrote:
>>> Some PWM drivers enable the clock of the PWM peripheral in
>>> pwm_enable(). Hence,
>>> for these drivers, a call to pwm_config() does not have any effect
>>> before
>>> pwm_enable() has been called.
>>>
>>> This patch fixes the PWM users to make sure that they call
>>> pwm_enable() before
>>> pwm_config().
>>>
>>> This fixes the first setting of brightness through sysfs that had
>>> no effect with
>>> leds-pwm and the i.MX PWM driver.
>>
>> But isn't this a bug in the PWM peripheral driver? With this change
>> the PWM
>> will start with the old settings first. While this is not so much of
>> a problem
>> for a backlight (although it might cause a short flickering) it migh=
t
>> cause
>> problems for other applications, like using the PWM pin as a timing
>> generator.
>> In my opinion it's better to fix the PWM peripheral drivers which
>> have this
>> problem instead of trying to work around it in every user of the PWM
>> API.
>=20
> I don't know. See my detailed description of this issue here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115=
667.html
>=20
> Where the bug is depends on the detailed definition of the PWM API, w=
hich I
> don't find documented anywhere.
>=20
> If pwm_enable() means "start PWM timer with the configured settings",=
 then the
> bug is in the drivers. If it means "enable the PWM peripheral so that=
 we can
> work with it", then the bug is in the PWM users.

It really is the former. See the description of pwm_enable() in drivers=
/pwm/core.c

>=20
> I don't really have time to work on this, so I suggested this patch a=
s a simple
> solution. Otherwise, it means reworking several PWM drivers for diffe=
rent
> hardware that is not available to everyone for testing.
>=20
> If we decide to only change the i.MX PWM driver, the fix would be:
> pwm_config()
> {
>         save passed config in private data;
>         if (pwm enabled)
>                 apply passed config;
> }
>=20
> pwm_enable()
> {
>         if (!(pwm enabled)) {
>                 enable pwm ip clk;
>                 apply config from private data;
>         }
> }

Another option is to enable the clock if it is disabled when the device=
 is
configured. E.g. that's what tegra does.

>=20
> If we fix only this driver, we must not forget that the same issue pr=
obably
> exists with several other PWM drivers.
>=20

Since this seems to be a common pattern in a number of PWM drivers it m=
ight
make sense to simply add support for enabling/disabling a clk to the pw=
m core.
Or maybe just use the runtime pm API for this. This probably makes even=
 more
sense and grab a reference to the pm context when the enable() is calle=
d,
release it when disable() is called and also grab it before calling the
device's config callback and release it afterward.

- Lars
