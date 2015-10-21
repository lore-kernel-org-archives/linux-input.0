From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Report full pressure range for Intuos, Cintiq
 13HD Touch
Date: Wed, 21 Oct 2015 11:21:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510211121230.21100@pobox.suse.cz>
References: <1444929426-1723-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38564 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbJUJVf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 05:21:35 -0400
In-Reply-To: <1444929426-1723-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 15 Oct 2015, Jason Gerecke wrote:

> The new Intuos tablets added in eda01da and the Cintiq 13HD Touch added
> in b4bf212 are capable of reporting 2048 levels of pressure. Although the
> kernel reports the correct range to userspace, an oversight has resulted
> in the driver ingoring the 11th pressure bit and only sending pressures
> of 0 through 1023.
> 
> We could fix this issue by expanding the type check to include these
> devices, but it makes much more sense to just have the driver look at
> the device's maximum pressure when determining if it should read the
> 11th bit.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.4/wacom.

-- 
Jiri Kosina
SUSE Labs

