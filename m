From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv4 1/2] drivers: input: keypad: Add device tree support
Date: Thu, 26 Apr 2012 08:39:36 -0600
Message-ID: <4F995E28.1050203@wwwdotorg.org>
References: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>	<4F981CD1.2050007@wwwdotorg.org> <CAKdam56ONhS_drgfHCeY6aKWp3nT0PtDEO5SMCKxG+dGVPS66A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45576 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab2DZOjl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 10:39:41 -0400
In-Reply-To: <CAKdam56ONhS_drgfHCeY6aKWp3nT0PtDEO5SMCKxG+dGVPS66A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>

On 04/26/2012 12:33 AM, Poddar, Sourav wrote:
> On Wed, Apr 25, 2012 at 9:18 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
...
>> It's probably worth considering whether num-rows/columns should be part
>> of matrix-keyboard.txt, and whether linux,keypad-no-autorepeat should be
>> part of some core keyboard binding. Some of the properties in
>> tegra-kbc.txt might be worth generalizing too (debounce/repeat delay,
>> ghost filter)?
>
> Yes, I also think that its a good idea to make some of the above
> binding more generic. Though, I think "linux,keypad-no-autorepeat"
> will still be a custom binding, since its totally on the platform
> whether to use
> autorepeat feature or not?

I think the concept of whether autorepeat should be enabled is pretty
generic. The actual value of the property might well be
board/platform-specific, so may differ in individual board .dts files.
