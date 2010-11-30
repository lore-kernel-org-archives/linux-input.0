From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH WIP 0/6] suggested changes to gpio_buttons driver
Date: Tue, 30 Nov 2010 19:26:53 +0100
Message-ID: <4CF541ED.80905@openwrt.org>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>	<cover.1290631852.git.bengardiner@nanometrics.ca>	<20101130075610.GB15731@core.coreip.homeip.net>	<4CF4D241.1090401@openwrt.org> <AANLkTikv6CV-z1pkvwvRd+ahv3AvKzXVB0XivNT6G2XB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:59739 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0K3S1A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:27:00 -0500
In-Reply-To: <AANLkTikv6CV-z1pkvwvRd+ahv3AvKzXVB0XivNT6G2XB@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Ben, Dmitry,

>> <...>
>> It works for me, however I have additional fixes on top of Ben's changes. I will
>> post an updated version soon.
> 
> This "polled gpio keys" driver was your invention. FWIW, I think your
> upcoming updated version should be given consideration before
> proceeding with the collection of patches discussed above.
> 
>> The original driver was a part of a patch-set which adds support for a new MIPS
>> platform. There are a couple of patches in that series which requires this one.
>> It would be nice if the driver would be able to go through the MIPS tree to
>> avoid cross-tree dependencies.
> 
> Since the da850-evm series which depends on this patch is proposed for
> the linux-davinci tree I think that to avoid cross-tree dependencies
> they would all need to be taken in one tree. That is, unless there is
> zero chance of the da850-evm series being taken-up for 2.6.38 along
> with this driver. I have added Kevin Hilman, the linux-davinci
> maintainer, and Sekhar Nori, the da850-evm maintainer, to the CC of
> this email so that they can participate in the discussion of when and
> how the patches should be merged.
> 
> Kevin, Sekhar, do you think that "da850-evm: add gpio-{keys,leds} for
> UI and BB expanders" could be queued for 2.6.38?

Well, I had to rethink that a bit. In my original patch-set I have several
patches which must be acked by other subsystem maintainers.

Given the possibility that my patch-set will not be merged for 2.6.38 I will
drop the driver from that set so the driver can go through any tree.
Additionally I will post my changes in a follow up e-mail. Those changes goes on
top of Dmitry's changes, so the whole stuff can be folded into the original patch.

Regards,
Gabor
