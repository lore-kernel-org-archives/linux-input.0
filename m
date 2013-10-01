From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
Date: Tue, 01 Oct 2013 11:51:11 +0100
Message-ID: <524AA91F.7000906@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
 <201310011128.38928.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201310011128.38928.jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jic23@cam.ac.uk, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 10/01/13 10:28, J=FCrgen Beisert wrote:
> Hi Jonathan,
> =

> On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
>> a couple of the patch descriptions say that they are untested on i.MX28.
> =

> On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
>> For battery driven systems it is a very bad idea to collect the touchscr=
een
>> data within a kernel busy loop.
>>
>> This change uses the features of the hardware to delay and accumulate
>> samples in hardware to avoid a high interrupt and CPU load.
>>
>> Note: this is only tested on an i.MX23 SoC yet.
> =

> This note is no longer true. Marek tested it on his M28EVK, Lothar on his=
 TX28 =

> and myself also on an i.MX28EVK.
> =

> For the IIO part of the driver I tested on my i.MX23 based ChumbyOne and =
some =

> customer hardware and it seems still to work (I can only guess if the val=
ues I =

> read from the sysfs entries are correct, sorry).

Excellent. I'll assume everyone is happy then and add some appropriate
tested-by tags. I'd missed Marek's reply saying he was fine with this.


Thanks,

Jonathan
> =

> Regards,
> Juergen
> =
