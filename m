From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCHv3] input: gpio_keys: polling mode support
Date: Sat, 24 Jul 2010 21:17:51 +0200
Message-ID: <877hkkd6zk.fsf@tac.ki.iif.hu>
References: <20100706190128.GB24655@chipmunk> <20100712192950.GR6976@chipmunk>
	<20100713011707.GA12728@linux-sh.org>
	<20100713012819.GA15800@core.coreip.homeip.net>
	<20100713072605.GS6976@chipmunk> <20100713195745.GJ2428@chipmunk>
	<20100713200455.GK2428@chipmunk> <87fwzf40yo.fsf@tac.ki.iif.hu>
	<20100724074646.GA3615@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:45669 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755852Ab0GXTR5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jul 2010 15:17:57 -0400
In-Reply-To: <20100724074646.GA3615@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Sat, 24 Jul 2010 00:46:46 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexander Clouter <alex@digriz.org.uk>, linux-input@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Gabor Juhos <juhosg@openwrt.org>, Nuno Goncalves <nunojpg@gmail.com>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, Jul 19, 2010 at 11:26:55PM +0200, Ferenc Wagner wrote:
> 
>> Just in case you didn't know: there's an alternate implementation at
>> https://dev.openwrt.org/browser/trunk/target/linux/generic-2.6/files/drivers/input/misc/gpio_buttons.c?rev=21436
>
> Hmm, I might like this option best of all. We just need to rename the
> driver so that we can have both polled and interrupt driven compiled,
> Then we'd bind based on device name creatd for us.
>
> Can you submit it officially?

Hi,

Actually, I'm not affiliated with that code, I just happened to run into
it some time ago.  I put its authors on Cc, they sure can help you
better.  I'd expect them to very gladly submit it, thus reducing the
delta between OpenWRT and upstream Linux. :)
-- 
Regards,
Feri.
