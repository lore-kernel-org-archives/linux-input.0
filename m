From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: fix buffer allocations
Date: Mon, 3 Feb 2014 11:03:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402031102110.14066@pobox.suse.cz>
References: <1391314990-29046-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbaBCKDK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Feb 2014 05:03:10 -0500
In-Reply-To: <1391314990-29046-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 1 Feb 2014, Benjamin Tissoires wrote:

> When using hid_output_report(), the buffer should be allocated by hid_alloc_report_buf(),
> not a custom malloc.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Good catch, applied, thanks.

-- 
Jiri Kosina
SUSE Labs
