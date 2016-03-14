From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Release all touch slots on
 reset_resume
Date: Mon, 14 Mar 2016 10:10:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603141010040.3656@cbobk.fhfr.pm>
References: <20160311221949.GA14029@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbcCNJKZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 05:10:25 -0400
In-Reply-To: <20160311221949.GA14029@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 11 Mar 2016, Dmitry Torokhov wrote:

> From: Benson Leung <bleung@chromium.org>
> 
> When resetting a device (especially after power loss) it is unlikely
> that the firmware will keep the contact tracking data for the previous
> touches and will be able to reconcile it with the new contacts, so
> let's release all slots on reset resume as start anew.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Applied to for-4.6/multitouch.

-- 
Jiri Kosina
SUSE Labs

