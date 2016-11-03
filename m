From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: Fix !CONFIG_PM build warning
Date: Thu, 3 Nov 2016 12:12:41 -0600 (MDT)
Message-ID: <alpine.LNX.2.00.1611031212270.5061@cbobk.fhfr.pm>
References: <20161029111740.741-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757846AbcKCSMo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 14:12:44 -0400
In-Reply-To: <20161029111740.741-1-bp@alien8.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Sat, 29 Oct 2016, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Fix
> 
>   drivers/hid/intel-ish-hid/ipc/pci-ish.c:247:12: warning: ‘ish_suspend’ defined but not used [-Wunused-function]
>    static int ish_suspend(struct device *device)
>               ^
>   drivers/hid/intel-ish-hid/ipc/pci-ish.c:282:12: warning: ‘ish_resume’ defined but not used [-Wunused-function]
>    static int ish_resume(struct device *device)
>             ^
> by sticking them in the CONFIG_PM range too.

Applied to hid.git#for-4.9/upstream-fixes

Thanks,

-- 
Jiri Kosina
SUSE Labs

