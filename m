From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 4/5] qt602240_ts: add optional hooks for board specific
 reset	logic
Date: Thu, 18 Nov 2010 20:32:39 +0900
Message-ID: <4CE50ED7.8000802@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204206.28796.34520.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44209 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0KRLcl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 06:32:41 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC200DG5W2FSQ70@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:32:39 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC2004FJW2FF5@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:32:39 +0900 (KST)
In-reply-to: <20101116204206.28796.34520.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi, Chris.

On 2010-11-17 =EC=98=A4=EC=A0=84 5:42, Chris Leech wrote:
> Hooks for board specific setup and tear-down, to be used if the contr=
ollers
> reset is wired to a GPIO pin.
>
> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
> ---
>   drivers/input/touchscreen/qt602240_ts.c |    7 +++++++
>   include/linux/i2c/qt602240_ts.h         |    4 ++++
>   2 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/=
touchscreen/qt602240_ts.c
> index 11055ec..efe975e 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -1307,6 +1307,11 @@ static int __devinit qt602240_probe(struct i2c=
_client *client,
>
>   	i2c_set_clientdata(client, data);
>
> +	if (data->pdata->hw_setup) {
> +		error =3D data->pdata->hw_setup(client);
> +		if (error)
> +			goto err_free_object;
> +	}
>   	error =3D qt602240_initialize(data);
>   	if (error)
>   		goto err_free_object;
> @@ -1376,6 +1381,8 @@ static int __devexit qt602240_remove(struct i2c=
_client *client)
>   	sysfs_remove_group(&client->dev.kobj,&qt602240_attr_group);
>   	free_irq(data->irq, data);
>   	input_unregister_device(data->input_dev);
> +	if (data->pdata->hw_teardown)
> +		data->pdata->hw_teardown(client);
>   	kfree(data->object_table);
>   	kfree(data);
>
> diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt60=
2240_ts.h
> index d2aa1b6..764dd45 100644
> --- a/include/linux/i2c/qt602240_ts.h
> +++ b/include/linux/i2c/qt602240_ts.h
> @@ -41,6 +41,10 @@ struct qt602240_platform_data {
>   	 * platform_data).
>   	 */
>   	unsigned char trust_nvm;
> +
> +	/* Board-specific HW hooks; NULL if not needed */
> +	int (*hw_setup) (struct i2c_client *client);
> +	void (*hw_teardown) (struct i2c_client *client);

Why does client need?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
