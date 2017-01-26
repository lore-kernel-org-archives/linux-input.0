From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid-lg: Fix immediate disconnection of Logitech
 Rumblepad 2
Date: Thu, 26 Jan 2017 21:59:39 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701262159070.25515@cbobk.fhfr.pm>
References: <bd414b27-d1c8-9395-7552-5dfe9a3ce63a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45287 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbdAZU7k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 15:59:40 -0500
In-Reply-To: <bd414b27-d1c8-9395-7552-5dfe9a3ce63a@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ardinar23@gmail.com
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 26 Jan 2017, Ardinartsev Nikita wrote:

> hid-lg: Fix immediate disconnection of Logitech Rumblepad 2
> 
> With NOGET quirk Logitech F510 is now fully workable in dinput mode including
> rumble effects (according to fftest).
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091
> Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>

The patch has been line-wrapped by your mail clinet. Please fix that up 
for any future submissions.

I've now fixed it up manually on my side and applied, thanks.

-- 
Jiri Kosina
SUSE Labs

