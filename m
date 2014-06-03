From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: input - Add two new usages for digitizer
Date: Tue, 3 Jun 2014 13:32:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406031332020.11302@pobox.suse.cz>
References: <1401754792-5607-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38699 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbaFCLcO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2014 07:32:14 -0400
In-Reply-To: <1401754792-5607-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Mon, 2 Jun 2014, Ping Cheng wrote:

> On Feb 17, 2014, two new usages are approved to HID usage Table 18 -
> Digitizer Page:
> 
> 5A	Secondary Barrel Switch		MC	16.4
> 5B	Transducer Serial Number	SV	16.3.1
> 
> This patch adds relevant definitions to hid/input. It also removes
> outdated comments in hid.h.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
