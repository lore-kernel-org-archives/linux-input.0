From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: fix i2c_hid_output_raw_report
Date: Thu, 31 Jan 2013 17:58:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301311758170.23853@pobox.suse.cz>
References: <1359651002-16562-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab3AaQ6j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 11:58:39 -0500
In-Reply-To: <1359651002-16562-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 31 Jan 2013, Benjamin Tissoires wrote:

> i2c_hid_output_raw_report is used by hidraw to forward set_report requests.
> The current implementation of i2c_hid_set_report needs to take the
> report_id as an argument. The report_id is stored in the first byte
> of the buffer in argument of i2c_hid_output_raw_report.
> 
> Not removing the report_id from the given buffer adds this byte 2 times
> in the command, leading to a non working command.
> 
> Reported-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Applied, will push it for 3.8 still. Thanks,

-- 
Jiri Kosina
SUSE Labs
