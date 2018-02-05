From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] drivers/input/misc/pcap: a possible sleep-in-atomic bug in
 pcap_keys_handler
Date: Mon, 5 Feb 2018 15:25:14 -0800
Message-ID: <20180205232514.GE46524@dtor-ws>
References: <9af81fe8-e07c-9161-2d85-3eb23a198ec9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9af81fe8-e07c-9161-2d85-3eb23a198ec9@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>
Cc: ilya.muromec@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 12, 2017 at 04:32:01PM +0800, Jia-Ju Bai wrote:
> According to drivers/input/misc/pcap_keys.c, the kernel module may sleep in
> the interrupt handler.
> The function call path is:
> pcap_keys_handler (interrupt handler)
>   ezx_pcap_read
>     mutex_lock --> may sleep
> 
> I do not find a good way to fix it, so I only report.
> This possible bug is found by my static analysis tool (DSAC) and checked by
> my code review.

Let's see if Daniel's email still work. I am not sure how it worked to
begin with, given that we've been taking that mutex since very
beginning, and pcap_isr_work() disables local interrupts...

Thanks.
 
-- 
Dmitry
