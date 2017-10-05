From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hyperv: pr_err() strings should end with newlines
Date: Thu, 5 Oct 2017 11:28:38 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710051128150.14384@jbgna.fhfr.qr>
References: <c8e6ee81076db223671e9ad93966a8c89145ab7f.1506340963.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbdJEJ2k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Oct 2017 05:28:40 -0400
In-Reply-To: <c8e6ee81076db223671e9ad93966a8c89145ab7f.1506340963.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, benjamin.tissoires@redhat.com, devel@linuxdriverproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 25 Sep 2017, Arvind Yadav wrote:

> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-4.15/hyperv.

-- 
Jiri Kosina
SUSE Labs

