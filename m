From: Matthew Leach <matthew@mattleach.net>
Subject: Re: [PATCH] HID: hid-input: fix double-free in cleanup_battery
Date: Wed, 12 Aug 2015 13:15:29 +0100
Message-ID: <1439381729.357.0.camel@mattleach.net>
References: <1439381384-13733-1-git-send-email-matthew@mattleach.net>
	 <alpine.LNX.2.00.1508121515370.27871@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1508121515370.27871@pobox.suse.cz>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2015-08-12 at 15:16 +0200, Jiri Kosina wrote:
> On Wed, 12 Aug 2015, Matthew Leach wrote:
> 
> > The power supply layer has taken control of the power supply 
> objects
> > from the drivers to core, see [1].  As such, calling
> > power_supply_unregister is enough to free the power_supply device.
> > 
> > Remove the extra kfree's as the power_supply core will handle 
> freeing
> > the power_supply object for us.
> 
> Please see commit 0621809e37 ("HID: hid-input: Fix accessing freed 
> memory 
> during device disconnect") in Linus' tree.

Ah.  I missed that.  Sorry for the noise.
-- 
Matt
