From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] Refresh lid state on resume
Date: Tue, 31 Jul 2007 14:18:15 +0100
Message-ID: <1185887895.5338.2.camel@hughsie-laptop>
References: <1184670921.8890.2.camel@work>
	 <1185808891.18821.25.camel@queen.suse.de>
	 <1185809610.24649.3.camel@hughsie-laptop>  <200707311108.42947.rjw@sisk.pl>
	 <1185872842.2652.11.camel@hughsie-laptop>
	 <1185878536.18821.129.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1185878536.18821.129.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: trenn@suse.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-07-31 at 12:42 +0200, Thomas Renninger wrote:
> Richard, could you give attached patch a try, pls.
> Also check that platform suspend mode is used. AFAIK this isn't called
> at all in suspend mode.

The attached patch works for me with a git kernel on my X60. I'm not in
the office today so I can't test it on other machines.

The suspend was called using echo mem > /sys/power/state

Thanks,

Richard.


