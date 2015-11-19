From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: Make report_descriptor available for all devices
Date: Thu, 19 Nov 2015 23:18:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511192317580.20111@pobox.suse.cz>
References: <8e1380539994340dd37e16abcc21c75cf9fc6e89.1447949840.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58001 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934293AbbKSWS3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 17:18:29 -0500
In-Reply-To: <8e1380539994340dd37e16abcc21c75cf9fc6e89.1447949840.git.luto@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-input@vger.kernel.org

On Thu, 19 Nov 2015, Andy Lutomirski wrote:

> Currently the sysfs report_descriptor attribute is only available if
> the device is claimed.  We have the descriptor before we even create
> the device node, so just instantiate report_descriptor statically.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Agreed, that's generally useful; applied to for-4.5/core branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

