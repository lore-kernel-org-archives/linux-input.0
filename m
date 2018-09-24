From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/9] HID: intel ISH: Cleanup patches
Date: Mon, 24 Sep 2018 11:21:59 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809241121470.15880@cbobk.fhfr.pm>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Sep 2018, Srinivas Pandruvada wrote:

> This series is a cleanup series only and help to abstract client API.
> 
> There are no functional changes.
> 
> Even Xu (6):
>   hid: intel-ish-hid: ishtp: add helper function for driver data get/set
>   hid: intel-ish-hid: use helper function for private driver data
>     set/get
>   hid: intel-ish-hid: ishtp: add helper functions for client buffer
>     operation
>   hid: intel-ish-hid: use helper function to access client buffer
>   hid: intel-ish-hid: ishtp: add helper function for client search
>   hid: intel-ish-hid: use helper function to search client id
> 
> Hong Liu (2):
>   HID: intel-ish-hid: use resource-managed api
>   HID: intel-ish-hid: using list_head for ipc write queue
> 
> Srinivas Pandruvada (1):
>   HID: intel_ish-hid: Enhance API to get ring buffer sizes

Applied to for-4.20/ish.

-- 
Jiri Kosina
SUSE Labs
