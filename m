From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: HID: intel_ish-hid: tx_buf memory leak on probe/remove
Date: Mon, 23 Jul 2018 14:55:41 -0700
Message-ID: <fbac7919db6874c76ef3ac628c8356968bb55d7a.camel@linux.intel.com>
References: <a0faf8a7-17ea-0ed3-5bb5-f1e8fb5debf6@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0faf8a7-17ea-0ed3-5bb5-f1e8fb5debf6@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

On Mon, 2018-07-23 at 20:56 +0300, Anton Vasilyev wrote:
> ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores
> it at
> &dev->wr_free_list_head.link list on ish_probe().
> But there is no deallocation of this memory in ish_remove() and in 
> ish_probe()
> error path.
> So current intel-ish-ipc provides 88 KB memory leak for each
> probe/release.
> 
> I have two ideas 1) to replace kzalloc allocation by devm_kzalloc,
Thanks for finding this. We can replace both alloc in this function
with devm_ calls. Once you have a patch I can test.

Thanks,
Srinivas 

> or 2) release memory stored at &dev->wr_free_list_head.link list
> (and 
> may be at
> &dev->wr_processing_list_head.link) in all driver exits.
> 
> But I do not know which way is preferable for this case.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> --
> Anton Vasilyev
> Linux Verification Center, ISPRAS
> web: http://linuxtesting.org
> e-mail: vasilyev@ispras.ru
