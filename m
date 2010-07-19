From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCHv3] input: gpio_keys: polling mode support
Date: Mon, 19 Jul 2010 23:26:55 +0200
Message-ID: <87fwzf40yo.fsf@tac.ki.iif.hu>
References: <20100706190128.GB24655@chipmunk> <20100712192950.GR6976@chipmunk>
	<20100713011707.GA12728@linux-sh.org>
	<20100713012819.GA15800@core.coreip.homeip.net>
	<20100713072605.GS6976@chipmunk> <20100713195745.GJ2428@chipmunk>
	<20100713200455.GK2428@chipmunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:40646 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966352Ab0GSVz6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jul 2010 17:55:58 -0400
In-Reply-To: <20100713200455.GK2428@chipmunk> (Alexander Clouter's message of
	"Tue, 13 Jul 2010 21:04:55 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Clouter <alex@digriz.org.uk>
Cc: linux-input@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

Just in case you didn't know: there's an alternate implementation at
https://dev.openwrt.org/browser/trunk/target/linux/generic-2.6/files/drivers/input/misc/gpio_buttons.c?rev=21436
-- 
Regards,
Feri.
