From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH 1/2] Input: gpio-keys: allow drivers to specify whether IRQ can be shared
Date: Fri, 20 Nov 2009 11:08:31 +0100
Message-ID: <87r5rty0dc.fsf@tac.ki.iif.hu>
References: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
	<dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
	<20091120083817.GB3009@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:36767 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbZKTKI1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 05:08:27 -0500
In-Reply-To: <20091120083817.GB3009@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Fri, 20 Nov 2009 00:38:17 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Thu, Nov 19, 2009 at 09:23:45AM +0200, Mika Westerberg wrote:
>
>> Added new field to struct gpio_keys_button: exclusive_irq which can
>> be used to specify whether driver wants to have exclusive access to
>> IRQ or can it be shared. By default IRQs for gpio-keys are shareable.
>
> I think the idea makes sense with one exception - why limit just to
> sharing and not let platform specify the exact IRQ flags it needs,
> defaulting to IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_SHARED?

Though I'm all for level triggered GPIO buttons, that would hardly fly
without changes in the handler logic.  And for the necessary change of
polarity one needs GPIO access, and we're back to Arve's as-yet-
unanswered question: "If gpio_get_value may sleep, then what is
gpio_get_value_cansleep for?"  There was also talk about using the
nested interrupt infrastructure, but I didn't really get you, and the
thread died off without conclusion:
http://thread.gmane.org/gmane.linux.kernel.input/8775/focus=9153
I'd appreciate some explanation, if you can afford the time.
-- 
Regards,
Feri.
