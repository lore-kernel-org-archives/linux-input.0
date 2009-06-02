From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
 adapter
Date: Tue, 2 Jun 2009 11:16:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906021113030.7457@wotan.suse.de>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz> <alpine.LNX.2.00.0905111749530.22712@wotan.suse.de> <4A084A0C.3070500@suse.cz> <4A1A700B.8020805@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56468 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbZFBJQI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Jun 2009 05:16:08 -0400
In-Reply-To: <4A1A700B.8020805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 25 May 2009, Jiri Slaby wrote:

> This will cover most of current drivers and hence we might eliminate 
> almost all blacklisted entries (except the ones for drivers with 
> report_fixup).

Which is OK, as usually they wouldn't work at all anyway without fixed 
report descriptor (or will be behaving in unexpected bogus way). The other 
features (force feedback and missing mappings) are not that crucial 
anyway.

Plus, my longer-term intention is to move all the special mapping into 
HAL.

> Caveats:
> * events come even when stopped: drop (or hold) events until inputs are
>   connected again

By this you mean the short window start-stop-start during bootup, or 
something else?

> * complexity: added complexity, slowdown in initialization and handling

The slowdown shouldn't really be problem in case of HID, the devices 
themselves are usually pretty slow.

Thanks,

-- 
Jiri Kosina
SUSE Labs
