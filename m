From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] HID: add missing hid usages
Date: Mon, 28 Apr 2014 17:00:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404281659140.8903@pobox.suse.cz>
References: <1398450404-20484-1-git-send-email-ogay@logitech.com> <20140425183043.GC12355@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33404 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbaD1PAa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2014 11:00:30 -0400
In-Reply-To: <20140425183043.GC12355@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Fri, 25 Apr 2014, Dmitry Torokhov wrote:

> > Add some missing hid usages from consumer page, add
> > some display brightness control usages from approved hid usage
> > table request HUTTR41:
> > http://www.usb.org/developers/hidpage/HUTRR41.pdf
> > and add voice command usage from approved request HUTTR45:
> > http://www.usb.org/developers/hidpage/Voice_Command_Usage.pdf
> > 
> > Signed-off-by: Olivier Gay <ogay@logitech.com>
> > Signed-off-by: Mathieu Meisser <mmeisser@logitech.com>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> with a small nit below. Probably Jiri can fix it up without resubmitting.

Absolutely; applied now.

Thanks,

-- 
Jiri Kosina
SUSE Labs
