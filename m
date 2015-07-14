From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v1] HID: cp2112: fix byte order in SMBUS operations
Date: Tue, 14 Jul 2015 22:43:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507142243250.7522@pobox.suse.cz>
References: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:51708 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbGNUoA (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Tue, 14 Jul 2015 16:44:00 -0400
In-Reply-To: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, 9 Jul 2015, Ellen Wang wrote:

> Change all occurrences of be16 to le16 in cp2112_xfer(),
> because SMBUS words are little endian, not big endian.
> 
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>

I've tagged this for stable and applied to for-4.3/cp2112.

-- 
Jiri Kosina
SUSE Labs
