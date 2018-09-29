From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
Date: Sat, 29 Sep 2018 21:20:07 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com> <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm> <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 29 Sep 2018, Jia-Ju Bai wrote:

> >> picolcd_send_and_wait (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> picolcd_reset (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> lg4ff_play (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> lg4ff_set_autocenter_ffex (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> > Hm, so it's always drivers calling out into core in atomic context. So
> > either we take this, and put our bets on being able to allocate the buffer
> > without sleeping,
> 
> In my opinion, I prefer this way.

Why? Forcing all the report buffer to be limited to be non-sleeping 
allocations just because of two drivers, looks like an overkill, and 
actually calls for more issues (as GFP_ATOMIC is of course in principle 
less likely to succeed).

-- 
Jiri Kosina
SUSE Labs
