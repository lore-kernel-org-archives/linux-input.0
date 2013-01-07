From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Mon, 7 Jan 2013 23:49:10 +0530
Message-ID: <CAKohpon_h2ehq5Cf-fVyne33y7iyXCD35FVV1yuhgoDDstEcFQ@mail.gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201301071613.33573.marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 7 January 2013 20:43, Marek Vasut <marex@denx.de> wrote:
>> > The new
>> > behaviour is the expected one and copies the behavior of
>> > platform_data-based probe.
>>
>> Blindly copying platform data behaviour to DT bindings is seldom a good
>> idea.
>
> Do you have suggestions how to pass these information? I suspect the irq-over-
> gpio property can be killed, since if irq-gpios prop is there, it implies irq-
> over-gpio anyway.

Both can be killed. gpios as interrupt lines can be requested as:

 interrupt-parent = <&gpio-controller>;
 interrupts = <25 0x1>;

and probably the stmpe driver doesn't have to bother at all if
interrupt was over gpio
or not.
