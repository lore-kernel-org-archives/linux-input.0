Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F44C433DB
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EDE64E2E
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBQUwg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:52:36 -0500
Received: from chill.innovation.ch ([216.218.245.220]:46168 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhBQUwg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Feb 2021 15:52:36 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2021 15:52:36 EST
Date:   Wed, 17 Feb 2021 12:45:51 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 625E86413BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1613594751;
        bh=jgl5n7zvz1NXJJpwMxfxUeOze+Q5T6JtyLCxle0khm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtZuhDMnNcMCdRx5FP8AMqUI5+5DGQdZ9S9Gib0mJK+tl04e5Vcy/yKR3TiP3n+0R
         S7ZotnapW/ABA2kaoLtJn8CEcBpg3RVt/b1zyybjONAZlPU0jmW1Xm6W2zHfvyxpdU
         wwO884JuX5bsdt4vTXD288cyBrk0R1StjC2TT0nGBay+UM9V90YQxStJphMlu9HYAi
         ZqraCemQpsCndnat2iMtuyRlck72Cx27rMckk/1Lta9ZYGeoJ1TsG1ihpJfIFDzqL+
         ZCyL4Uz4zRKPzJ9RhFSjJAUFj+55QnvXWyuvEVMQxQT03+3icRcvf2wJ3W31V2PHCm
         Aaoe+t5JWPqxg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: applespi: Don't wait for responses to
 commands indefinitely.
Message-ID: <20210217204551.GA25685@innovation.ch>
References: <20210217190718.11035-1-ronald@innovation.ch>
 <YC17OycMiNipMUyn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YC17OycMiNipMUyn@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


  Hi Dmitry,

On Wed, Feb 17, 2021 at 12:23:23PM -0800, Dmitry Torokhov wrote:
> 
> On Wed, Feb 17, 2021 at 11:07:16AM -0800, Ronald Tschalär wrote:
> > @@ -869,7 +878,7 @@ static int applespi_send_cmd_msg(struct applespi_data *applespi)
> >  		return sts;
> >  	}
> >  
> > -	applespi->cmd_msg_queued = true;
> > +	applespi->cmd_msg_queued = ktime_get();
> 
> Will it be OK if I change this to ktime_get_coarse()? I do not think we
> need exact time here, and the coarse variant is cheaper I believe.

Certainly - I just wasn't aware of the coarse variant.


  Cheers,

  Ronald

