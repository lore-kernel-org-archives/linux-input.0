From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: Use hid_report_len to compute the size of
 reports
Date: Mon, 12 Jan 2015 10:14:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501121014030.15299@pobox.suse.cz>
References: <1420757496-3955-1-git-send-email-aduggan@synaptics.com> <1420757496-3955-3-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42897 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbbALJOY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 04:14:24 -0500
In-Reply-To: <1420757496-3955-3-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 8 Jan 2015, Andrew Duggan wrote:

> Now that hid_report_len is in hid.h we can use this function instead of
> duplicating the code which computes it.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-3.20/rmi.

-- 
Jiri Kosina
SUSE Labs
