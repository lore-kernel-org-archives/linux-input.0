From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 00/10] HID: intel-ish-hid: Clean up external
 interfaces
Date: Tue, 19 Mar 2019 11:59:49 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903191158230.19912@cbobk.fhfr.pm>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 18 Mar 2019, Srinivas Pandruvada wrote:

> NOT FOR kernel v5.1.
> 
> v2
> - Rebased on the top of
> "HID: intel-ish: enable raw interface to HID devices on ISH"
> which Jiri already applied.
> - Also exported devc pointer for DMA

I've already reviewed v1 before, so I just went through these highlighted 
changes above, and applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs
