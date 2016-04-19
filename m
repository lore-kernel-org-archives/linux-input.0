From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/5] input: twl6040-vibra: add handler to unregister input if module is removed
Date: Tue, 19 Apr 2016 09:33:10 +0200
Message-ID: <E0529B06-0584-49B9-976A-368875810385@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <89f53877b821049c789256dd1b0c0b1dbb604de9.1461009340.git.hns@goldelico.com> <20160418211257.GA1006@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:29959 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcDSHdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 03:33:19 -0400
In-Reply-To: <20160418211257.GA1006@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org


> Am 18.04.2016 um 23:12 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Mon, Apr 18, 2016 at 09:55:38PM +0200, H. Nikolaus Schaller wrote:
>> commit 1f9e1470ab34 ("Input: twl6040-vibra - use devm functions")
>> 
>> converted everything to devm but we still need to call
>> input_unregister_device(info->input_dev)
> 
> No, this is not needed, because devm-managed input devices will be
> unregistered automatically.

Well, it would, if the current driver would use devm for registration. But it appears not to do it that way (line 375):

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/misc/twl6040-vibra.c?id=refs/tags/v4.6-rc4#n375

So we either have to fix line 375 or add the proposed explicit unregister call.

Research shows me that you did propose devm_input_register_device() some years ago but this API was never included:

https://lkml.org/lkml/2012/10/29/855

> 
>> 
>> Solution: add back twl6040_vibra_remove to call input_unregister_device
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/input/misc/twl6040-vibra.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
>> index 7221a00..1e9902d 100644
>> --- a/drivers/input/misc/twl6040-vibra.c
>> +++ b/drivers/input/misc/twl6040-vibra.c
>> @@ -384,8 +384,18 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>> 	return 0;
>> }
>> 
>> +static int twl6040_vibra_remove(struct platform_device *pdev)
>> +{
>> +	struct vibra_info *info = platform_get_drvdata(pdev);
>> +
>> +	input_unregister_device(info->input_dev);
>> +
>> +	return 0;
>> +	}
>> +
>> static struct platform_driver twl6040_vibra_driver = {
>> 	.probe		= twl6040_vibra_probe,
>> +	.remove		= twl6040_vibra_remove,
>> 	.driver		= {
>> 		.name	= "twl6040-vibra",
>> 		.pm	= &twl6040_vibra_pm_ops,
>> -- 
>> 2.7.3
>> 
> 
> Thanks.
> 
> -- 
> Dmitry

