Return-Path: <SRS0=RGIC=6U=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF8C28CBC
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 06:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F40206E6
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 06:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEFGit (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 6 May 2020 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgEFGit (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 May 2020 02:38:49 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F93AC061A0F
        for <linux-input@vger.kernel.org>; Tue,  5 May 2020 23:38:49 -0700 (PDT)
Received: from [192.168.178.106] (pD95EF25B.dip0.t-ipconnect.de [217.94.242.91])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8A83D404C98;
        Wed,  6 May 2020 06:36:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] input: touch: ads7846: switch to devm
 initialization
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-input@vger.kernel.org
References: <20200504173745.1246505-1-daniel@zonque.org>
 <20200504173745.1246505-2-daniel@zonque.org>
 <20200505083701.GB18755@pengutronix.de> <20200506000539.GA70193@dtor-ws>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <2e5ae797-c89f-f8a1-eb92-d7e504ad3f32@zonque.org>
Date:   Wed, 6 May 2020 08:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506000539.GA70193@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for having a look!

On 5/6/20 2:05 AM, Dmitry Torokhov wrote:
> On Tue, May 05, 2020 at 10:37:01AM +0200, Marco Felsch wrote:
>> On 20-05-04 19:37, Daniel Mack wrote:
>>> @@ -1488,30 +1472,11 @@ static int ads7846_remove(struct spi_device *spi)
>>>  	struct ads7846 *ts = spi_get_drvdata(spi);
>>>  
>>>  	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
>>> -
>>>  	ads7846_disable(ts);
>>> -	free_irq(ts->spi->irq, ts);
>>> -
>>> -	input_unregister_device(ts->input);
>>> -
>>> -	ads784x_hwmon_unregister(spi, ts);
>>> -
>>> -	regulator_put(ts->reg);
>>> -
>>> -	if (!ts->get_pendown_state) {
>>> -		/*
>>> -		 * If we are not using specialized pendown method we must
>>> -		 * have been relying on gpio we set up ourselves.
>>> -		 */
>>> -		gpio_free(ts->gpio_pendown);
>>> -	}
>>>  
>>>  	if (ts->filter_cleanup)
>>>  		ts->filter_cleanup(ts->filter_data);
> 
> This makes filter_cleanup() be called much earlier now, before we free
> interrupt, unregister input device, etc.
> 
> I am very concerned with mixing manual unwinding and devm and would
> very much prefer if everything would be converted to devm.

Yes, I see. These filter_init()/filter_cleanup() functions can
potentially be set by pdata users, hence I thought it's easiest if we
keep it as-is.

However, turns out this pdata logic has no active user in mainline, so I
can just add a patch to remove it completely and simplify the code further.

Will pick up yours and Marco's comments and put them in a v3.


Thanks!
Daniel
