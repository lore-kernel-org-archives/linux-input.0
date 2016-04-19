From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 5/5] input: twl6040-vibra: remove mutex
Date: Tue, 19 Apr 2016 09:49:01 +0200
Message-ID: <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <592912a81a86fe0c9b5eaf3407cc5c4e1bfef9fe.1461009340.git.hns@goldelico.com> <20160418212048.GB1006@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:59014 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcDSHtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 03:49:07 -0400
In-Reply-To: <20160418212048.GB1006@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org


> Am 18.04.2016 um 23:20 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Mon, Apr 18, 2016 at 09:55:41PM +0200, H. Nikolaus Schaller wrote:
>> The mutex does not seem to be needed.
> 
> twl6040_vibra_suspend() and vibra_play_work() may run concurrently, no?

Hm. I don't know about the rule that would give an answer to this question...

I will test a little to see if the mutex has unexpected side-effects.

> 
>> twl4030-vibra doesn't
>> use one either.
> 
> It probably should.
> 
> Thanks.
> 
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/input/misc/twl6040-vibra.c | 15 +--------------
>> 1 file changed, 1 insertion(+), 14 deletions(-)
>> 
>> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
>> index 69c5940..dcc926b 100644
>> --- a/drivers/input/misc/twl6040-vibra.c
>> +++ b/drivers/input/misc/twl6040-vibra.c
>> @@ -46,7 +46,7 @@ struct vibra_info {
>> 	struct device *dev;
>> 	struct input_dev *input_dev;
>> 	struct work_struct play_work;
>> -	struct mutex mutex;
>> +
>> 	int irq;
>> 
>> 	bool enabled;
>> @@ -182,8 +182,6 @@ static void vibra_play_work(struct work_struct *work)
>> 	struct vibra_info *info = container_of(work,
>> 				struct vibra_info, play_work);
>> 
>> -	mutex_lock(&info->mutex);
>> -
>> 	if (info->weak_speed || info->strong_speed) {
>> 		if (!info->enabled)
>> 			twl6040_vibra_enable(info);
>> @@ -192,7 +190,6 @@ static void vibra_play_work(struct work_struct *work)
>> 	} else if (info->enabled)
>> 		twl6040_vibra_disable(info);
>> 
>> -	mutex_unlock(&info->mutex);
>> }
>> 
>> static int vibra_play(struct input_dev *input, void *data,
>> @@ -223,12 +220,8 @@ static void twl6040_vibra_close(struct input_dev *input)
>> 
>> 	cancel_work_sync(&info->play_work);
>> 
>> -	mutex_lock(&info->mutex);
>> -
>> 	if (info->enabled)
>> 		twl6040_vibra_disable(info);
>> -
>> -	mutex_unlock(&info->mutex);
>> }
>> 
>> static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
>> @@ -236,13 +229,9 @@ static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	struct vibra_info *info = platform_get_drvdata(pdev);
>> 
>> -	mutex_lock(&info->mutex);
>> -
>> 	if (info->enabled)
>> 		twl6040_vibra_disable(info);
>> 
>> -	mutex_unlock(&info->mutex);
>> -
>> 	return 0;
>> }
>> 
>> @@ -301,8 +290,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>> 		return -EINVAL;
>> 	}
>> 
>> -	mutex_init(&info->mutex);
>> -
>> 	error = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
>> 					  twl6040_vib_irq_handler,
>> 					  IRQF_ONESHOT,
>> -- 
>> 2.7.3
>> 
> 
> -- 
> Dmitry

