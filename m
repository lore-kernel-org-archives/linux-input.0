From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Override incorrect logical maximum contact
 identifier
Date: Thu, 20 Apr 2017 11:33:37 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704201131120.12121@cbobk.fhfr.pm>
References: <20170419214724.16959-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S944009AbdDTJdl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Apr 2017 05:33:41 -0400
In-Reply-To: <20170419214724.16959-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 19 Apr 2017, Jason Gerecke wrote:

> It apears that devices designed around Wacom's G11 chipset (e.g. Lenovo
> ThinkPad Yoga 260, Lenovo ThinkPad X1 Yoga, Dell XPS 12 9250, Dell Venue
> 8 Pro 5855, etc.) suffer from a common issue in their HID descriptors.
> The logical maximum is not updated for the "Contact Identifier" usage,
> leaving it as just "1" despite these devices being capable of tracking
> far more touches.
> 
> Commit 60a221869803 began ignoring usages with out-of-range values,
> causing problems for devices based on this chipset. Touches after
> the first will have an out-of-range Contact Identifier, and ignoring
> that usage will cause the kernel to incorrectly slot each finger's
> events (along with all the knock-on userspace effects that entails).
> 
> This commit checks for these buggy descriptors and updates the maximum
> where required. Prior chipsets have used "255" as the maximum (and the
> G11, at least, doesn't seem to actually use IDs outside the range of
> 1..CONTACTMAX) so continue using this value.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Jiri, please add this to your 'for-4.11/upstream-fixes' branch since
> commit 60a221869803 was introduced in 4.11 and leaving this unaddressed
> could impact a wide variety of tablet PCs.

60a221869803 has actually been present since 4.10-rc1, therefore I've 
added

	Cc: stable@vger.kernel.org
	Fixes: 60a221869803 ("HID: wacom: generic: add support for touchring")

to make sure all the affected stables will eventually get it.

-- 
Jiri Kosina
SUSE Labs

