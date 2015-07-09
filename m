From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v3] HID: cp2112: support large i2c transfers in
 hid-cp2112
Date: Thu, 9 Jul 2015 14:17:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507091416070.10183@pobox.suse.cz>
References: <1436379459-8263-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59680 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbGIMRm (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 08:17:42 -0400
In-Reply-To: <1436379459-8263-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, 8 Jul 2015, Ellen Wang wrote:

> cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
> on longers reads.  The fix is to wrap a loop around
> cp2112_read() to pick up all the returned data.
> 
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> ---
> This is the updated patch with a check for 0 return from
> cp2112_read().  I tested it with a suitable delay in the loop
> to trigger the cp2112_raw_event() overrun bug, which must
> be fixed before this patch is applied.

Now applied to for-4.3/cp2112 (which is based on for-4.2/upstream-fixes, 
where the overrun in ->raw_event() callback is fixed). So please send any 
potential updates as followups on top of this patch.

-- 
Jiri Kosina
SUSE Labs
