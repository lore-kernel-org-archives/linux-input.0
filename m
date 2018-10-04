From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
Date: Thu, 4 Oct 2018 09:35:35 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810040935090.14430@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com> <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm> <4c0096c6-3745-963c-5086-5f579792599b@gmail.com> <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
 <6bea4185-3325-b04d-56ed-2fdf4c74d8ae@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6bea4185-3325-b04d-56ed-2fdf4c74d8ae@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 4 Oct 2018, Jia-Ju Bai wrote:

> > Why? Forcing all the report buffer to be limited to be non-sleeping
> > allocations just because of two drivers, looks like an overkill, and
> > actually calls for more issues (as GFP_ATOMIC is of course in principle
> > less likely to succeed).
> 
> Okay, I thought that using GFP_ATOMIC is the simplest way to fix these bugs.
> But I check the Linux kernel code again, and find that hid_hw_request() are
> called at many places.
> So changing this function may affect many drivers.
> I agree to only change the two drivers, and explicitly anotate __hid_request()
> with might_sleep().

Thanks. Are you planning to submit a patch to do that?

-- 
Jiri Kosina
SUSE Labs
