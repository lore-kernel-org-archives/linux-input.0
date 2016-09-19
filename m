From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: alps: Fix memory leak
Date: Mon, 19 Sep 2016 14:43:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609191442430.22028@cbobk.fhfr.pm>
References: <1473566941-25149-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753895AbcISMnG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 08:43:06 -0400
In-Reply-To: <1473566941-25149-1-git-send-email-axel.lin@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sun, 11 Sep 2016, Axel Lin wrote:

> A kfree(readbuf) call was missed if hid_hw_raw_request() fails, fix it.
> Also avoid mixing direct return with goto in the error paths.

Applied to hid.git#for-4.8/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

