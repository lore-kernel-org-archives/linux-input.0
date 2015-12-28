From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Add rumble and LED support for Nyko Core
 Controller
Date: Mon, 28 Dec 2015 13:29:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512281328390.9922@cbobk.fhfr.pm>
References: <1449717999-11079-1-git-send-email-oreaus@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35231 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbbL1M3d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 07:29:33 -0500
In-Reply-To: <1449717999-11079-1-git-send-email-oreaus@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Moreau <oreaus@gmail.com>
Cc: linux-input@vger.kernel.org, ao2@ao2.it, frank.praznik@oh.rr.com

On Wed, 9 Dec 2015, Scott Moreau wrote:

> The Nyko Core Controller, vendor:1345 product:3008, is a usb controller marketed
> as a PS3 controller. It works as an HID device for input. It has a single left
> rumble motor and no accelerometers, so it isn't a sixaxis. This patch adds rumble
> and led support in the hid-sony driver.

Scott,

the patch is missing your Signoff; as such, it unfortunately can't be 
merged. Please see Documentation/SubmittingPatches for details.

Antonio, Frank, I'd like to have your Ack for this one as well is 
possible.

Thanks,

-- 
Jiri Kosina
SUSE Labs

