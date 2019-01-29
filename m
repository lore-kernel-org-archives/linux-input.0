From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
Date: Tue, 29 Jan 2019 10:16:51 +0100
Message-ID: <20190129091651.GA8497@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
 <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi,
On Mon, Jan 28, 2019 at 07:24:33PM +0100, Bastien Nocera wrote:
> On Mon, 2019-01-28 at 18:03 +0100, Guido G=FCnther wrote:
> > From what I've seen in vendor trees it's fine to treat this as gt1x=B9.
> > =

> > [1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drive=
rs/input/touchscreen/mediatek/GT5688
> =

> Can you please point to the exact line of code that makes you say that?
> I'm not saying it's not compatible, but it's not the same driver that
> the current goodix.c was based on, or even goodix.c.
>
> Can you please elaborate?

I basically looked at the registers uses for the config update:

https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/=
touchscreen/mediatek/GT5688/include/gt1x_tpd_common.h#L152
https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/=
touchscreen/mediatek/GT5688/gt1x_generic.c#L430

That and the fact that the driver is doing it's job well made me believe
that's good for base support. Things like hotknot, gesture wakeup and
proximity sensor will need additional work.

> Finding that data in the specs would also be fine:
> https://github.com/hadess/gt9xx/tree/master/specifications

https://github.com/hadess/gt9xx/pull/3

Cheers,
 -- Guido
