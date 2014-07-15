From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] Input: Add driver for Microchip's CAP1106
Date: Tue, 15 Jul 2014 11:12:22 +0200
Message-ID: <53C4F076.1070500@zonque.org>
References: <1405073193-21448-1-git-send-email-zonque@gmail.com> <20140714095247.GB4980@leverpostej> <53C3AEE1.4030805@zonque.org> <20140715085138.GR26465@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:46765 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932662AbaGOJMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 05:12:25 -0400
In-Reply-To: <20140715085138.GR26465@leverpostej>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "dtor@mail.ru" <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 07/15/2014 10:51 AM, Mark Rutland wrote:
> On Mon, Jul 14, 2014 at 11:20:17AM +0100, Daniel Mack wrote:

>> Hmm, I thought about that, but there are - in theory - more details that
>> could be specified per channel. I left those functions out for the first
>> version, as I have no good way to test them.
> 
> Ok. Could you elaborate on what those details might be? It might make
> sense to have these as nodes if there are arbitrary properties to
> describe for each button, but I'm not familiar enough with the hardware
> to make a call either way.

No, there are just settings that can be made for each indvidual
channel/button, such as sensitivity settings for instance. But they can
of course be specified in a similar manner as the keycodes, in a
fixed-size array. That's completely ok I think.

>> linux,keycode feels a bit overkill here though, so I'd rather go for a
>> fixed-size linux,keycodes property. The number of entries is fixed,
>> anyway. Would you be fine with that?
> 
> Assuming no-one's likely to want a sparse keymap (i.e. one where some
> keys do nothing) then that's probably ok.

If such a setup occurs, support for disabling channels could easily be
added, and in such cases, the keycode is simple ignored. I don't think a
sparse matrix keymap makes much sense here, especially as the buttons
are not organized in rows and columns.

>>> /me mutters usual grumblings about the autorepeat property.
>>
>> I took that from the gpio-keys driver. Is there a better way to denote
>> such a feature?
> 
> Unfortunately not, given current practice. My gripe is that it's a Linux
> detail that were describing rather than a property of the device. We can
> forget about that for now.

I see, so I'll leave it as it is.

I'll drop the input device unregister call as Dmitry said, and repost v5.


Thanks again!
Daniel

