From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: Remove unneeded linux/miscdevice.h
 include
Date: Mon, 19 Dec 2016 11:17:37 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191117300.19203@cbobk.fhfr.pm>
References: <20161215152711.9069-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161215152711.9069-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 15 Dec 2016, Corentin Labbe wrote:

> hid/intel-ish-hid does not use any miscdevice so this patch remove
> this unnecessary inclusion.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
