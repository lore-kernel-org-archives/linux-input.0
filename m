From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/14] HID: validate HID report id size
Date: Wed, 4 Sep 2013 12:11:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041208440.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48430 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab3IDKLd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 06:11:33 -0400
In-Reply-To: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

So I have now queued subset of the patches that don't deal with 
hid_validate_report(); waiting for v2 based on Benjamin's comments with 
the rest.

The patches are public for distributions to apply them if they feel urgent 
need, but for upstream I'd rather do things properly, and Benjamin had 
quite some valuable feedback.

Thanks again,

-- 
Jiri Kosina
SUSE Labs
