From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: sony: disable descriptor fixup for FutureMax
 Dance Mat
Date: Tue, 2 Aug 2016 16:43:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608021643060.22028@cbobk.fhfr.pm>
References: <20160721165448.14275-1-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35952 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbcHBSyX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 14:54:23 -0400
In-Reply-To: <20160721165448.14275-1-mikko.perttunen@kapsi.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: benjamin.tissoires@redhat.com, ao2@ao2.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On Thu, 21 Jul 2016, Mikko Perttunen wrote:

> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> The FutureMax Dance Mat claims to be a SixAxis controller
> but breaks if descriptor fixups are applied. Detect the
> device using its USB product string and disable fixups
> when it is detected.

What a mess; kudos to the HW vendors again.

Applied to for-4.8/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

