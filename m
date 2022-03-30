Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBBC433F5
	for <linux-input@archiver.kernel.org>; Wed, 30 Mar 2022 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiC3GmG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 30 Mar 2022 02:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiC3GmF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Mar 2022 02:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840621267;
        Tue, 29 Mar 2022 23:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9AD61692;
        Wed, 30 Mar 2022 06:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD8DC340EC;
        Wed, 30 Mar 2022 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648622418;
        bh=tnIIGDBs488Q5mc2fw2o+YS/Eu1rQ8caW02nQQNJwLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qC4pwfOxHcr/qRGovvMfoINpg2afyyfFlMYQ6OFGZaWEcwYDarhEGzEelo/aC1rYj
         FypcwybuyhphUoDxYShuJyaLf/KPm6DLqPSMb/P1nR2FHedEuYAYhpuGYKMuJ+aUO1
         UVBAPEjJj8mY9vrqCQZ/f1H9mWelEtQ6MQRnkbfQ=
Date:   Wed, 30 Mar 2022 08:40:16 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?7KGw7KSA7JmE?= <junwan.cho@samsung.com>
Cc:     "jikos@kernel.org" <jikos@kernel.org>,
        "michael.zaidman@gmail.com" <michael.zaidman@gmail.com>,
        "erazor_de@users.sourceforge.net" <erazor_de@users.sourceforge.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?utf-8?B?6rmA7J287Zi4?= <ih0923.kim@samsung.com>,
        =?utf-8?B?67CV7LKc7Zi4?= <chun.ho.park@samsung.com>,
        =?utf-8?B?67Cw7Jyk7Iud?= <yunsik.bae@samsung.com>,
        =?utf-8?B?6rCV64yA7Z2s?= <daihee7.kang@samsung.com>,
        =?utf-8?B?7J206rSR7Zi4?= <gaudium.lee@samsung.com>,
        =?utf-8?B?66WY7LKc7Jqw?= <chunwoo.ryu@samsung.com>,
        =?utf-8?B?64KY65GQ7IiY?= <doosu.na@samsung.com>,
        =?utf-8?B?6rmA7IiY7ZiE?= <suhyun_.kim@samsung.com>
Subject: Re: Request for reverting the commit for Samsung HID driver
Message-ID: <YkP7UFrbuDptaF03@kroah.com>
References: <CGME20220330062122epcms1p30a2c2e3e1d3b108d729a00034bf86587@epcms1p3>
 <20220330062122epcms1p30a2c2e3e1d3b108d729a00034bf86587@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330062122epcms1p30a2c2e3e1d3b108d729a00034bf86587@epcms1p3>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Mar 30, 2022 at 03:21:22PM +0900, 조준완 wrote:
>  
> 
>  
> 
> Dear Greg Kroah-Hartman,

<snip>

Please resend in non-html format so it properly makes it to the mailing
lists and I will gladly respond.

thanks,

greg k-h
