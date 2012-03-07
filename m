From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Wed, 7 Mar 2012 22:36:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44363 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2CGVgn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Mar 2012 16:36:43 -0500
In-Reply-To: <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Mar 2012, benjamin.tissoires wrote:

> From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> 
> The code is inspired from the one present in the bttv module.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
> 
> As I mentioned in the mail 0/5, I'd really like to have your opinion on this
> one. I copied the code from bttv, but it forces us to change hid_device which
> is not very good for ABI changes reasons.

Haven't closely inspected the patch yet, I will comment on it later. But 
generally, I wouldn't be worried about changing hid_device per se ... it's 
not really an ABI, it's not exported to userspace.

It's internal kernel-ABI, yes. But we are free to change that in any way 
we wish.

-- 
Jiri Kosina
SUSE Labs
