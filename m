Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D0C433DB
	for <linux-input@archiver.kernel.org>; Mon, 29 Mar 2021 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3C561969
	for <linux-input@archiver.kernel.org>; Mon, 29 Mar 2021 15:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2PW4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhC2PWu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Mar 2021 11:22:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C676187E;
        Mon, 29 Mar 2021 15:22:47 +0000 (UTC)
Date:   Mon, 29 Mar 2021 16:22:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/25] HID: hid-sensor-hub: Move 'hsdev' description to
 correct struct definition
Message-ID: <20210329162251.0b4a7fbf@jic23-huawei>
In-Reply-To: <20210329130007.GE2916463@dell>
References: <20210326143458.508959-1-lee.jones@linaro.org>
        <20210326143458.508959-25-lee.jones@linaro.org>
        <20210329123020.10250228@jic23-huawei>
        <20210329130007.GE2916463@dell>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 29 Mar 2021 14:00:07 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Mon, 29 Mar 2021, Jonathan Cameron wrote:
> 
> > On Fri, 26 Mar 2021 14:34:56 +0000
> > Lee Jones <lee.jones@linaro.org> wrote:
> >   
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/hid/hid-sensor-hub.c:54: warning: Function parameter or member 'hsdev' not described in 'hid_sensor_hub_callbacks_list'
> > >   
> > 
> > Perhaps nice to mention that this was a result of
> > 
> > ca2ed12f163b ("HID: hid-sensor-hub: Processing for duplicate physical ids")  
> 
> I only tend to do that for Fixes: tags, but Greg has made it clear
> that these patches are not suitable for stable.

Ok, I was deliberately not including Fixes for that reason, but
I guess some other script might moan if we do that :)

> 
> > > Cc: Jiri Kosina <jikos@kernel.org>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Cc: linux-input@vger.kernel.org
> > > Cc: linux-iio@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> 
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks dude, much appreciated.
> 

