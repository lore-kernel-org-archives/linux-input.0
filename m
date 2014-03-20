From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: add support for Win 8.1 multitouch
 touchpads
Date: Thu, 20 Mar 2014 10:02:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz>
References: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45997 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbaCTJCh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2014 05:02:37 -0400
In-Reply-To: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, rydberg@euromail.se

On Wed, 19 Mar 2014, Andrew Duggan wrote:

> Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
> in order to start reporting multitouch events. This is the same process sent
> to Win 7 multitouch touchscreens except the value of the feature report is 3 for
> touchpads.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
