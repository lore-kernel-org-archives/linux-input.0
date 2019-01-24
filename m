From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: intel-ish-hid: Switch to use new generic UUID
 API
Date: Thu, 24 Jan 2019 23:00:26 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1901242300020.6626@cbobk.fhfr.pm>
References: <20190124200906.60296-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124200906.60296-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, 24 Jan 2019, Andy Shevchenko wrote:

> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-5.1/ish branch, thanks.

-- 
Jiri Kosina
SUSE Labs
