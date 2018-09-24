From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
Date: Mon, 24 Sep 2018 11:26:06 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913033432.16336-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 13 Sep 2018, Jia-Ju Bai wrote:

> hid_alloc_report_buf() has to be called with GFP_ATOMIC in 
> __hid_request(), because there are the following callchains 
> leading to __hid_request() being an atomic context:
> 
> picolcd_send_and_wait (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> picolcd_reset (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> lg4ff_play (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)
> 
> lg4ff_set_autocenter_ffex (acquire a spinlock)
>   hid_hw_request
>     __hid_request
>       hid_alloc_report_buf(GFP_KERNEL)

Hm, so it's always drivers calling out into core in atomic context. So 
either we take this, and put our bets on being able to allocate the buffer 
without sleeping, or actually fix the few drivers (it's just lg4ff and 
picolcd at the end of the day) not to do that, and explicitly anotate 
__hid_request() with might_sleep().

Hmm?

Thanks,

-- 
Jiri Kosina
SUSE Labs
