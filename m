From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Apply lowres quirk to BAMBOO_TOUCH devices
Date: Tue, 8 Dec 2015 15:13:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512081512540.9922@cbobk.fhfr.pm>
References: <1449269127-23508-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59123 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067AbbLHONE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Dec 2015 09:13:04 -0500
In-Reply-To: <1449269127-23508-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 4 Dec 2015, Jason Gerecke wrote:

> When splitting the touch-only "BAMBOO_TOUCH" type out of the existing
> "BAMBOO_PT" type in 3b164a00, the lowres quirk was not updated so that
> it would continue to apply to these devices (effectively only the 0xD0).
> The absence of this quirk does not significantly impact usability, but
> is a correctness issue nonetheless.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.5/wacom.

-- 
Jiri Kosina
SUSE Labs

