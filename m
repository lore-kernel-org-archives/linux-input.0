From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: intel_ish-hid: tx_buf memory leak on
 probe/remove
Date: Thu, 2 Aug 2018 13:28:38 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808021328300.25787@cbobk.fhfr.pm>
References: <20180801112651.6032-1-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801112651.6032-1-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Aug 2018, Anton Vasilyev wrote:

> ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores it at
> &dev->wr_free_list_head.link list on ish_probe().
> But there is no deallocation of this memory in ish_remove() and in
> ish_probe() error path.
> So current intel-ish-ipc provides 88 KB memory leak for each
> probe/release.
> 
> The patch replaces kzalloc allocation by devm_kzalloc and removes
> ishtp_device *dev deallocation by kfree.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2: Fix align for multi line statements

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
