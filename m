From: simon@mungewell.org
Subject: Re: [PATCH 4/7] HID: sony: Add offsets and battery calculations for
 parsing Dualshock 4 reports sent via Bluetooth.
Date: Wed, 29 Jan 2014 16:36:14 -0500
Message-ID: <35de065b2fa99f0d984e05b14241164a.squirrel@mungewell.org>
References: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
    <1391016797-12842-5-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46830 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaA2VgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 16:36:16 -0500
In-Reply-To: <1391016797-12842-5-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>


> When the controller isn't connected to a power source and the battery is
> discharging, the battery level is reported from 0 to 9 instead of 1 to 11.

> +	battery_capacity = rd[offset] & 0x0F;

>  	if (battery_capacity > 10)
>  		battery_capacity--;

Hi Frank,
You might want to change this to
--
  	if (battery_capacity > 10)
  		battery_capacity = 10;
--

As the report could return values of 12..15, it's just that you haven't
seen them yet.

It might be that they're just giving a rough estimation based on cell
voltage, which might change over temp/life-time... this would also explain
the slightly lower value when the battery is under load.

It would be nice if they had another bit indicating charging, rather than
relying on the (assumed) voltage measurement. But it is what it is.

Cheers,
Simon.



