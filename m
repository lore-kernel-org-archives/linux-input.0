From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 14:54:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com> <20150714114917.GG1517@katana>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59917 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbGNMyz (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Tue, 14 Jul 2015 08:54:55 -0400
In-Reply-To: <20150714114917.GG1517@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Mon, 13 Jul 2015, Ellen Wang wrote:

> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
> the data to be written is in "command" not "data->byte".
> 
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> ---
> Forgot signed-off-by tag last time, sorry.

Applied to for-4.3/cp2112.

On Tue, 14 Jul 2015, Wolfram Sang wrote:

> Wow, that driver seems to be largely untested. Thanks for cleaning it
> up! Sidenote: i2c drivers should really be in drivers/i2c ;)

Well, it's sometimes a bit on the borderline where HID drivers should live 
(because they often, in addition to HID layer, make use of some other 
transport). If you want to move it under your wings, please send a patch 
that moves it and I'll Ack it.

-- 
Jiri Kosina
SUSE Labs
