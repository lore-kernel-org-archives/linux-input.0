From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Tue, 11 Nov 2008 18:36:23 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz>
References: <49109C91.6090207@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:32934 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752246AbYKKRgY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 12:36:24 -0500
In-Reply-To: <49109C91.6090207@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 Nov 2008, Henrik Rydberg wrote:

> The unibody MacBook 5 and MacBook Pro 5 come with a new version of
> the bcm5974 trackpad. This patch adds the USB device ids and all
> the appropriate quirks, including hid_blacklist.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied, thanks Henrik (and sorry for the delay, I have been offline for a 
few days).

-- 
Jiri Kosina
SUSE Labs
