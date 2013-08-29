From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/14] HID: validate HID report id size
Date: Thu, 29 Aug 2013 11:03:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308291102380.23267@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47026 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab3H2JDJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 05:03:09 -0400
In-Reply-To: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>

On Wed, 28 Aug 2013, Jiri Kosina wrote:

> From: Kees Cook <keescook@chromium.org>
> 
> The "Report ID" field of a HID report is used to build indexes of
> reports. The kernel's index of these is limited to 256 entries, so any
> malicious device that sets a Report ID greater than 255 will trigger
> memory corruption on the host:
> 
> [ 1347.156239] BUG: unable to handle kernel paging request at ffff88094958a878
> [ 1347.156261] IP: [<ffffffff813e4da0>] hid_register_report+0x2a/0x8b
> 
> CVE-2013-2888
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org

Applied this one to hid.git#for-3.11/CVE-2013-2888

Thanks,

-- 
Jiri Kosina
SUSE Labs
