From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Use tablet-provided touch height/width values
 for INTUOSHT
Date: Tue, 18 Aug 2015 15:17:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508181517030.25821@pobox.suse.cz>
References: <1439858513-10581-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60748 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbbHRNRL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 09:17:11 -0400
In-Reply-To: <1439858513-10581-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 17 Aug 2015, Jason Gerecke wrote:

> The current generation of "Intuos" tablets (i.e. INTUOSHT) report touch
> width and height data just like the "Intuos Pro" do. This commit changes
> the code to allow these tablets to use the appropriate codepath instead
> of the one intended for Intuos5/Bamboo.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.3/wacom.

-- 
Jiri Kosina
SUSE Labs

