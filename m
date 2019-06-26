From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [UPDATE][PATCH v4] HID: intel-ish-hid: fix wrong driver_data
 usage
Date: Wed, 26 Jun 2019 14:09:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906261409130.27227@cbobk.fhfr.pm>
References: <20190606045227.7515-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606045227.7515-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, even.xu@intel.com, hyungwoo.yang@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 5 Jun 2019, Srinivas Pandruvada wrote:

> From: Hyungwoo Yang <hyungwoo.yang@intel.com>
> 
> Currently, in suspend() and resume(), ishtp client drivers are using
> driver_data to get "struct ishtp_cl_device" object which is set by
> bus driver. It's wrong since the driver_data should not be owned bus.
> driver_data should be owned by the corresponding ishtp client driver.
> Due to this, some ishtp client driver like cros_ec_ishtp which uses
> its driver_data to transfer its data to its child doesn't work correctly.
> 
> So this patch removes setting driver_data in bus drier and instead of
> using driver_data to get "struct ishtp_cl_device", since "struct device"
> is embedded in "struct ishtp_cl_device", we introduce a helper function
> that returns "struct ishtp_cl_device" from "struct device".
> 
> Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-5.2/fixes.

-- 
Jiri Kosina
SUSE Labs
