From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Process invalid Cintiq and Intuos data in
 wacom_intuos_inout
Date: Mon, 12 Jan 2015 10:18:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501121017420.15299@pobox.suse.cz>
References: <1420830290-5053-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43121 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbALJSE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 04:18:04 -0500
In-Reply-To: <1420830290-5053-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, 9 Jan 2015, Ping Cheng wrote:

> Users may use unsupported tools on Cintiq or Intuos. When invalid
> tools or data are detected, they should be ignored. That is, no
> event from those tools should be reported.
> 
> Consolidating that code in wacom_intuos_inout simplifies the logic
> and make it easier for future code change.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v2: Added commit comments as suggested by Jiri Kosina.

Both patches applied to for-3.20/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs
