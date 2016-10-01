From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: elan_i2c - fix return tests of
 i2c_smbus_read_block_data()
Date: Fri, 30 Sep 2016 17:02:28 -0700
Message-ID: <20161001000228.GC1680@dtor-ws>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
 <1475073244-23068-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34732 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbcJAACb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Sep 2016 20:02:31 -0400
Content-Disposition: inline
In-Reply-To: <1475073244-23068-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 28, 2016 at 04:34:01PM +0200, Benjamin Tissoires wrote:
> i2c_smbus_read_block_data() returns negative errno else the number of
> data bytes in the slave's response.
> 
> Checking for error not null means the function always fails if the device
> answers properly.
> 
> So given that we read 3 bytes and access those, better check that we
> actually read those 3 bytes.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/elan_i2c_smbus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index cb6aecb..9b43b55 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -226,7 +226,7 @@ static int elan_smbus_get_max(struct i2c_client *client,
>  	u8 val[3];
>  
>  	error = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
> -	if (error) {
> +	if (error != 3) {
>  		dev_err(&client->dev, "failed to get dimensions: %d\n", error);
>  		return error;

Unfortunately that means you'll report success if you get 0 from
i2c_smbus_read_block_data() or confuse upper layers with positive
errors. I'll change this to:

	ret = i2c_smbus_read_block_data();
	if (ret != 3) {
		error = ret < 0 ? ret : -EIO;
		...
	}

Thanks.

>  	}
> @@ -245,7 +245,7 @@ static int elan_smbus_get_resolution(struct i2c_client *client,
>  
>  	error = i2c_smbus_read_block_data(client,
>  					  ETP_SMBUS_RESOLUTION_CMD, val);
> -	if (error) {
> +	if (error != 3) {
>  		dev_err(&client->dev, "failed to get resolution: %d\n", error);
>  		return error;
>  	}
> @@ -265,7 +265,7 @@ static int elan_smbus_get_num_traces(struct i2c_client *client,
>  
>  	error = i2c_smbus_read_block_data(client,
>  					  ETP_SMBUS_XY_TRACENUM_CMD, val);
> -	if (error) {
> +	if (error != 3) {
>  		dev_err(&client->dev, "failed to get trace info: %d\n", error);
>  		return error;
>  	}
> -- 
> 2.7.4
> 

-- 
Dmitry
