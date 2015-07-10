From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: cp2112: support i2c write-read transfers in
 hid-cp2112
Date: Fri, 10 Jul 2015 11:21:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507101120570.14897@pobox.suse.cz>
References: <1436504106-31740-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59576 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbGJJVf (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 10 Jul 2015 05:21:35 -0400
In-Reply-To: <1436504106-31740-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, 9 Jul 2015, Ellen Wang wrote:

> cp2112_i2c_xfer() only supports a single i2c_msg.  More than
> one message at a time just returns EIO.  This breaks certain
> important cases.  For example, the at24 eeprom driver generates
> paired write and read messages (for eeprom address and data).
> 
> Since the device doesn't support i2c repeated starts in general,
> but does support a single write-repeated-start-read pair
> (since hardware rev 1), we recognize the latter case and
> implement only that.
> 
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>

Applied to for-4.3/cp2112.

Thanks,

-- 
Jiri Kosina
SUSE Labs
