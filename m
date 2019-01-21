From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] HID: intel-ish-hid: Switch to use new generic UUID
 API
Date: Mon, 21 Jan 2019 09:40:08 +0100
Message-ID: <20190121084008.GA18680@lst.de>
References: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 10, 2019 at 05:48:04PM +0200, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  3 +--
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  6 +++---
>  drivers/hid/intel-ish-hid/ishtp/bus.c        | 19 ++++++++-----------
>  drivers/hid/intel-ish-hid/ishtp/bus.h        |  4 ++--
>  drivers/hid/intel-ish-hid/ishtp/client.h     |  2 +-
>  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  2 +-
>  6 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index e64243bc9c96..2246697ada1d 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -788,8 +788,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
>  	if (!cl_device)
>  		return	-ENODEV;
>  
> -	if (uuid_le_cmp(hid_ishtp_guid,
> -			cl_device->fw_client->props.protocol_name) != 0)
> +	if (!guid_equal(&hid_ishtp_guid, &cl_device->fw_client->props.protocol_name))

This adds an overly long line.

With that fixed:

Reviewed-by: Christoph Hellwig <hch@lst.de>
