From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: enable hid device to suspend/resume
 asynchronously
Date: Mon, 16 Nov 2015 16:26:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511161624360.20111@pobox.suse.cz>
References: <560392E7.1030207@linux.intel.com> <5649F3A3.8080007@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5649F3A3.8080007@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 16 Nov 2015, Fu, Zhonghui wrote:

> 
> Hi Jiri,
> 
> Any comments about this patch?
> 
> After enabling the HID devices suspend/resume asynchronously on ASUS 
> T100TA(Baytrail-T platform), the system suspend-to-idle/resume time is 
> reduced about 20ms. Although this improvement is not very significant. 
> But, if the suspend/resume operation of HID devices is very 
> time-consuming on some other platforms, this patch can improve 
> significantly system suspend/resume speed on these platforms.

Hi,

I don't think the question I've raised at

	http://lkml.kernel.org/r/alpine.LNX.2.00.1509251404130.30132@pobox.suse.cz

has ever been answered or at least discussed ... ?

-- 
Jiri Kosina
SUSE Labs
