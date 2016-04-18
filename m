From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] hid: thingm: factor out duplicated code to
 thingm_init_led
Date: Mon, 18 Apr 2016 13:03:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604181302530.27368@cbobk.fhfr.pm>
References: <5713F643.80408@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49418 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbcDRLDN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 07:03:13 -0400
In-Reply-To: <5713F643.80408@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sun, 17 Apr 2016, Heiner Kallweit wrote:

> Simplify thingm_init_rgb by factoring out duplicated code
> to thingm_init_led.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Both patches applied to for-4.7/thingm.

-- 
Jiri Kosina
SUSE Labs

