From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/4] HID: wacom - request tool info only when we get
 general events
Date: Mon, 18 Jan 2016 23:05:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601182305090.21446@cbobk.fhfr.pm>
References: <1452302094-5521-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60760 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871AbcARWFp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 17:05:45 -0500
In-Reply-To: <1452302094-5521-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

On Fri, 8 Jan 2016, Ping Cheng wrote:

> Move wacom_intuos_schedule_prox_event inside wacom_intuos_general
> so we don't call it when general event data isn't ready.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

I've applied the whole series to for-4.6/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs

