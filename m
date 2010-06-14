From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-input: Use a larger event buffer for MT devices
Date: Mon, 14 Jun 2010 13:55:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006141354040.12271@pobox.suse.cz>
References: <1276516181-4519-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59369 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab0FNLzH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 07:55:07 -0400
In-Reply-To: <1276516181-4519-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

On Mon, 14 Jun 2010, Henrik Rydberg wrote:

> The MT devices produce a lot of data. Tell the underlying input device
> approximately how many events will be sent per synchronization, to allow
> for better buffering. The number is a template based on continuously
> reporting details for each finger on a single hand.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Jiri,
> 
> This patch goes together with the evdev buffer patchset, which Dmitry
> is going to queue for 2.6.36.

So it makes sense to take it together with the rest of the patchset to 
avoid syncing problems between the trees.

Dmitry, could you please add

	Signed-off-by: Jiri Kosina <jkosina@suse.cz>

to Henrik's patch and take it through your tree together with the rest?

Thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
