From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] input: touchscreen: edt-ft5x06: don't make device
 a wakeup source by default
Date: Fri, 25 May 2018 10:52:36 -0500
Message-ID: <CAL_JsqKnmrMUqFq=fL0ZM5XCaRFpVaFcdHfd7jzUVkroymvCCA@mail.gmail.com>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-2-daniel@zonque.org>
 <20180522175413.GA24850@rob-hp-laptop>
 <52c1cd13-3386-8f70-aaf2-e5f4b19fd1e6@zonque.org>
 <CAL_JsqJQt6vFqH-KzNvjW+FZXCgzNAwXj_nSYow2Uz2Vcmi_Cg@mail.gmail.com>
 <20180524231732.GC177107@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180524231732.GC177107@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Thu, May 24, 2018 at 6:17 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, May 23, 2018 at 09:45:05AM -0500, Rob Herring wrote:
>> On Wed, May 23, 2018 at 3:27 AM, Daniel Mack <daniel@zonque.org> wrote:
>> > On Tuesday, May 22, 2018 07:54 PM, Rob Herring wrote:
>> >>
>> >> On Thu, May 17, 2018 at 11:05:50AM +0200, Daniel Mack wrote:
>> >>>
>> >>> Allow configuring the device as wakeup source through device properties,
>> >>> as
>> >>> not all platforms want to wake up on touch screen activity.
>> >>>
>> >>> The I2C core automatically reads the "wakeup-source" DT property to
>> >>> configure a device's wakeup capability, and board supports files can set
>> >>> I2C_CLIENT_WAKE in the flags.
>> >>
>> >>
>> >> This will break wake-up on working systems. Looks like mostly i.MX, but
>> >> there's one AM437x board. If that board doesn't care, then it is up to
>> >> Shawn.
>> >
>> >
>> > I added the property to the dts files, but as Dmitry pointed out, I missed
>> > some. Sorry for that.
>>
>> Just adding the property to dts files doesn't fix the compatibility
>> problem. If a user uses an existing dtb (before this change) with a
>> new kernel (after this change), then wakeup will stop working.
>
> Is this a practical problem though? Do we know of any products with
> this touch panel that use DTS not distributed with the kernel?

Distribution of dts with kernel is irrelevant. It is how the dtb's are
handled that matters. You still need to ask in tree users.

I can't have any way of knowing what DTs may exist as there is only
one upstream repository of dts files. There's not really a good
solution on this to avoid breaking users, so we'll just have to see if
anyone (besides the known users) complains.

Rob
