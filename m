From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] input: keyboard: gpio-keys-polled: use input name from
 pdata if available
Date: Thu, 14 Feb 2019 09:01:14 +0100
Message-ID: <089b2db5-50bc-e180-e39e-1e791bf6e044@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:


sorry for the late reply - lost your mail by broken filter :(
(just picked it out now of the archive ...)

> > Instead of hardcoding the input name to the driver name
('gpio-keys-polled'),
> > allow the passing a name via platform data ('name' field was already
present),
> > but default to old behaviour in case of NULL.

> I thought the world is moving away from platform data and towards
> OF/ACPI systems. What device are you targeting with this change?

Well, it that only would be available everywhere :o

I've written an platform driver for the APUv2 board, which has an
gpio-attached button and LEDs on the front. It's an x86 machine,
(= no OF), and no usable ACPI information (no, I won't patch up
the bios for that, unless somebody inserts enough coins ;-))

Therefore, I need to pass everything via platform data.

By the way: I've also added support for gpio lookup table.
(sending it w/ the next patch queue)

> I would want to convert gpio-keys[-polled] to generic device
> properties and away form platform data...

I'd like to see that too, but it's not that easy. Not all platforms
support proper generic configuration mechanisms.

Maybe it would be easier, if we had oftree everywhere, and drivers
for composite devices could directly inject (locally scoped) oftree
nodes.For example, a PCI-based GPU board which has lots of sub-devices
like regulators, sensors, fans, etc. The driver then would be probed via
PCI, declare it's own bus and probe the individual devices by it's
own of subtree. Well, that's gonna take a lot more discussions ...


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
