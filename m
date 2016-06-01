From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Add MT_QUIRK_NOT_SEEN_MEANS_UP to
 Surface Pro 3
Date: Wed, 1 Jun 2016 16:07:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606011607360.11844@cbobk.fhfr.pm>
References: <1464708675-25273-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57179 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbcFAOHq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Jun 2016 10:07:46 -0400
In-Reply-To: <1464708675-25273-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Martin <consume.noise@gmail.com>, Romain Sahut <romain.sahut@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 May 2016, Benjamin Tissoires wrote:

> The firmware found in the touch screen of an SP3 is buggy and may miss
> to send lift off reports for contacts. Try to work around that issue by
> using MT_QUIRK_NOT_SEEN_MEANS_UP.
> 
> based on a patch from: Daniel Martin <consume.noise@gmail.com>
> 

Applied to for-4.7/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

