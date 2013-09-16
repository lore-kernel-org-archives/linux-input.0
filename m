From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 16:30:32 +0100
Message-ID: <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-6-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201309161010.22151.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org



"J=C3=BCrgen Beisert" <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>Hi Jonathan,
>
>On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
>> On 09/11/13 09:18, Juergen Beisert wrote:
>> > For battery driven systems it is a very bad idea to collect the
>> > touchscreen data within a kernel busy loop.
>> >
>> > This change uses the features of the hardware to delay and
>accumulate
>> > samples in hardware to avoid a high interrupt and CPU load.
>> >
>> > Note: this is only tested on an i.MX23 SoC yet.
>> >
>> > Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> > CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> > CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
>> > CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> > CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
>>
>> While this driver is placed in IIO within staging at the moment,
>these
>> changes are definitely input related.  Hence I have cc'd Dmitry and
>the
>> input list.
>>
>> I am personaly a little uncomfortable that we have such a complex bi=
t
>of
>> input code sat within an IIO driver but such is life.
>
>Maybe an MFD for this ADC unit would be a better way to go?
That would be great and is definitely the preferred method.


 Currently I
>have a=20
>different problem with this driver, because the ADC unit monitors the
>battery=20
>as well. And the charging driver from the power subsystem needs these
>values=20
>to charge the battery in a correct manner.

There is an iio client battery driver as generic_ADC_battery.c but it i=
s currently only doing polled access. Not too hard to add buffered acce=
ss though ideally we would want a generic way of combining consumers do=
ing polled and interrupt driven accesses.
>
>> [...]
>
>Regards,
>Juergen

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
