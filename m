From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 1/2] input: rotary-encoder: switch to devm_*
 allocation of GPIOs and IRQs
Date: Wed, 25 Jul 2012 11:07:51 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206AABE1573@AUSP01VMBX24.collaborationhost.net>
References: <1343202228-1507-1-git-send-email-zonque@gmail.com>
 <20120725160510.GA6276@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail160.messagelabs.com ([216.82.253.99]:24238 "EHLO
	mail160.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab2GYQH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 12:07:57 -0400
In-Reply-To: <20120725160510.GA6276@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jhovold@gmail.com" <jhovold@gmail.com>

On Wednesday, July 25, 2012 9:05 AM, Dmitry Torokhov wrote:
> On Wed, Jul 25, 2012 at 09:43:47AM +0200, Daniel Mack wrote:
>> @@ -263,12 +243,7 @@ exit_free_mem:
>>  static int __devexit rotary_encoder_remove(struct platform_device *pdev)
>>  {
>>  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
>> -	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
>>  
>> -	free_irq(encoder->irq_a, encoder);
>> -	free_irq(encoder->irq_b, encoder);
>> -	gpio_free(pdata->gpio_a);
>> -	gpio_free(pdata->gpio_b);
>>  	input_unregister_device(encoder->input);
>
> Another botched devm_ conversion. *sigh*
>
> Input device gone, IRQ arrives, kernel goes oops, machine hangs hard.
>
> Please, do not use devm_ interfaces unless... Actually, just do not use
> nor suggest devm_interfaces until all resources are devm-ized. Mixing 2
> styles of releasing resources leads to trouble.

Oops.. Sorry about that. I didn't think about the interaction with
input_unregister_device.

Regards,
Hartley

