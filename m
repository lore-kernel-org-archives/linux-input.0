From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/4 v2] HID: wacom: generic: Don't return a value for
 wacom_wac_event
Date: Fri, 9 Dec 2016 13:27:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091326530.16984@cbobk.fhfr.pm>
References: <1481263407-6051-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752583AbcLIM1i (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 07:27:38 -0500
In-Reply-To: <1481263407-6051-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, jason.gerecke@wacom.com, Ping Cheng <ping.cheng@wacom.com>

On Thu, 8 Dec 2016, Ping Cheng wrote:

> From: Ping Cheng <pinglinux@gmail.com>
> 
> It is unnecessary to return a value since nothing is expecting a
> value from it.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> Reviewed-By: Jason Gerecke <jason.gerecke@wacom.com>

I have applied the series to for-4.1/wacom/generic, but please in the 
future try to invest more time into patch changelogs; they seem to have 
declining tendency in quality and details provided.

Thanks,

-- 
Jiri Kosina
SUSE Labs

