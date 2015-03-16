From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] HID: Stop hiding options with !EXPERT
Date: Mon, 16 Mar 2015 16:03:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161600510.25438@pobox.suse.cz>
References: <20150220173333.5a71d6cb@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220173333.5a71d6cb@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On Fri, 20 Feb 2015, Jean Delvare wrote:

> Many HID driver options are hidden unless EXPERT is set. While I
> understand the idea of simplifying the kernel configuration for most
> users, in practice I believe it adds more confusion than it helps.

OK, I think we've reached a point where this might actually be OK -- users 
which depended on those few drivers should now have explicit select in 
their .config anyway.

So I am applying this to for-4.1/kconfig-drop-expert-dependency, let's see 
whether we receive any complaints.

Thanks,

-- 
Jiri Kosina
SUSE Labs
