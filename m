From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Tue, 11 Nov 2008 23:48:31 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42405 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751219AbYKKWsc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 17:48:32 -0500
In-Reply-To: <4919C979.3000501@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 11 Nov 2008, Henrik Rydberg wrote:

> No worries. I should have mentioned earlier that the hid update is best 
> synchronized with the bcm5974 update, since the latter is the only 
> driver that will pick the mouse interface up after the hid update. The 
> bcm5974 patch was sent on October 23, but I have not received any 
> feedback to it yet.

Yes, I am aware of bcm5974 being dependent in HID driver not claiming the 
mouse interface on this hardware.

Dmitry, what are your plans with this bcm5974 patch? 2.6.28 or 2.6.29?

Thanks,

-- 
Jiri Kosina
SUSE Labs
