From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Tue, 9 Feb 2010 16:19:18 +0800
Message-ID: <f17812d71002090019n1facdbfw54f87da726333fa3@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	<f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	<bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	<bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
	<20100208113306.GN9007@buzzloop.caiaq.de>
	<6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
	<f17812d71002081705q7723c388re8582d1186802340@mail.gmail.com>
	<20100209073903.4d8a00e4@taxman.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100209073903.4d8a00e4@taxman.wild-wind.fr.eu.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <maz@misterjones.org>
Cc: Jebediah Huang <jebediah.huang@gmail.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 9, 2010 at 3:39 PM, Marc Zyngier <maz@misterjones.org> wrote:
> On Tue, 9 Feb 2010 09:05:22 +0800
> Eric Miao <eric.y.miao@gmail.com> wrote:
>
>> On Mon, Feb 8, 2010 at 8:32 PM, Marc Zyngier <maz@misterjones.org> wrote:
>> >> I just saw that there is indeed no support for irq line handling in this
>> >> driver. In order to use these lines as input for something like the
>> >> gpio_keys driver, support for that should be added. I never used this
>> >> driver and can't say whether it is under active development.
>> >
>> > It should be rather easy to introduce something similar to what I did for
>> > the pca953x driver (http://patchwork.kernel.org/patch/77418/)
>> >
>> > MAX732x seems a lot saner than PCA953x, as it has at least a hardware
>> > interrupt mask...
>>
>> Well, I'd say max732x is a chip of heavy simplification, input/output direction
>> of each pin is normally hardcoded, depending on the chip model used, there
>> seems no such interrupt mask registers for SW use really.
>
> I'm currently staring at the max7319 datasheet, and it really looks
> like there is such a register:
>
> "All input ports are continuously monitored for state changes
> (transition detection). Transitions are latched, allowing detection of
> transient changes. Any combination of inputs can be selected using the
> interrupt mask to assert the INT output. When the MAX7319 is
> subsequently accessed through the serial interface, any pending
> interrupt is cleared."
>
> So it would seems (although I agree with you that max732x as a GPIO
> expander is grossly simplified) that the feature is at least advertised.
>

That sounds like a good news. I'm seeing your previous implementation
of interrupt support on pca953x as a good one, so probably would be
good to follow that, and not sure Jebediah Huang can have this tested :-)
