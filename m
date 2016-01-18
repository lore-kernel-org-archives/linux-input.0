From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: sony: Add nyko core controller support
Date: Mon, 18 Jan 2016 23:11:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601182311110.21446@cbobk.fhfr.pm>
References: <1452696043-18362-1-git-send-email-oreaus@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32911 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871AbcARWLb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 17:11:31 -0500
In-Reply-To: <1452696043-18362-1-git-send-email-oreaus@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Moreau <oreaus@gmail.com>
Cc: linux-input@vger.kernel.org, ao2@ao2.it, frank.praznik@oh.rr.com

On Wed, 13 Jan 2016, Scott Moreau wrote:

> This adds rumble and LED support for nyko core controllers
> using the sino lite chip vendor:1345 product:3008, for PS3.
> 
> Setting operational mode and output reports are the same as
> sixaxis but the input report has a different format since the
> PS3 accepts HID usb devices. For it to work, an exception is
> needed to skip overriding the report descriptor and use the
> original one.
> 
> Signed-off-by: Scott Moreau <oreaus@gmail.com>

Applied both patches to for-4.6/sony.

Thanks,

-- 
Jiri Kosina
SUSE Labs

