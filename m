From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] i2c_hid: enable i2c-hid devices to suspend/resume
 asynchronously
Date: Mon, 6 Jun 2016 10:41:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606061041360.11844@cbobk.fhfr.pm>
References: <573D2900.6090903@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573D2900.6090903@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, dtor@chromium.org, bleung@chromium.org, Mika Westerberg <mika.westerberg@linux.intel.com>, aduggan@synaptics.com, k.kozlowski@samsung.com, dianders@chromium.org, gabriele.mzt@gmail.com, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 19 May 2016, Fu, Zhonghui wrote:

> i2c-hid devices' suspend/resume are usually time-consuming process.
> For example, the touch controller(i2c-ATML1000:00) on ASUS T100 tablet
> takes about 160ms for suspending and 120ms for resuming. This patch
> enables i2c-hid devices to suspend/resume asynchronously. This will
> take advantage of multicore and speed up system suspend/resume process.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 2e021ba..cc41e1e 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1020,6 +1020,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	pm_runtime_get_noresume(&client->dev);
>  	pm_runtime_set_active(&client->dev);
>  	pm_runtime_enable(&client->dev);
> +	device_enable_async_suspend(&client->dev);
>  
>  	ret = i2c_hid_fetch_hid_descriptor(ihid);
>  	if (ret < 0)

Applied to hid.git#for-4.8/i2c-hid.

-- 
Jiri Kosina
SUSE Labs
