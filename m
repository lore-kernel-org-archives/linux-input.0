From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: hid-led: add support for Delcom Visual Signal
 Indicator G2
Date: Thu, 7 Jul 2016 11:21:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607071121490.24757@cbobk.fhfr.pm>
References: <e804a266-95b3-5e1e-b3e8-930f27fe88d8@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35384 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbcGGJV7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jul 2016 05:21:59 -0400
In-Reply-To: <e804a266-95b3-5e1e-b3e8-930f27fe88d8@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sun, 3 Jul 2016, Heiner Kallweit wrote:

> I got hold of a Delcom Visual Signal Indicator G2 device.
> Unlike generation 1 devices generation 2 is fully HID-compliant
> what makes it easy to support them in the hid-led driver.
> 
> Just a small change to the framework is needed because Delcom doesn't
> use a fixed report id. Instead the report id is used to submit
> command information.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

