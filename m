From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-input: fix double-free in cleanup_battery
Date: Wed, 12 Aug 2015 15:16:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508121515370.27871@pobox.suse.cz>
References: <1439381384-13733-1-git-send-email-matthew@mattleach.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48181 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbbHLNQK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2015 09:16:10 -0400
In-Reply-To: <1439381384-13733-1-git-send-email-matthew@mattleach.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Leach <matthew@mattleach.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, stable@vger.kernel.org

On Wed, 12 Aug 2015, Matthew Leach wrote:

> The power supply layer has taken control of the power supply objects
> from the drivers to core, see [1].  As such, calling
> power_supply_unregister is enough to free the power_supply device.
> 
> Remove the extra kfree's as the power_supply core will handle freeing
> the power_supply object for us.

Please see commit 0621809e37 ("HID: hid-input: Fix accessing freed memory 
during device disconnect") in Linus' tree.

-- 
Jiri Kosina
SUSE Labs

