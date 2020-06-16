Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68600C433DF
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449812080D
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592320502;
	bh=yrnL9UpX/a11nNq4rn8b+jxH1C651aqSlV/dcI4pLBY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=P01WRc2GL/BGrkIQ7qKpuf2UDpXeOHtFpEWTNrALPkYA8ujIWYx8VdoCMOLDR3D+M
	 5uz9Cy9FKML7ztsmgC5ber5RKl9fXz0RVGvL2q3RlToo2NSaBMXAkRt6yLrOjES8sU
	 4owJI9ujEQtbIrvPBpReBqCMKYtsFEYpuwowXWTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgFPPPB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgFPPPB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 11:15:01 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AF9207C3;
        Tue, 16 Jun 2020 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592320501;
        bh=yrnL9UpX/a11nNq4rn8b+jxH1C651aqSlV/dcI4pLBY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XrEjTEvUsw82hLvg+MOfNxODiSCJoS4iInjheBywZPBY3ZL7B0eyzWvm6snliU9ra
         XWi5JbXfqTzHMnJpREBvuThJBHcBdNbroQuRCoTN3I46kRlDWzg/Gj4dfszbYFv92b
         s9OAbqRr1jSV1W9wP2XvK2V75k/952SdyMdG5KPE=
Date:   Tue, 16 Jun 2020 17:14:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        groeck@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: usbhid: do not sleep when opening device
In-Reply-To: <20200610043824.GA171503@dtor-ws>
Message-ID: <nycvar.YFH.7.76.2006161714270.13242@cbobk.fhfr.pm>
References: <20200610043824.GA171503@dtor-ws>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 9 Jun 2020, Dmitry Torokhov wrote:

> usbhid tries to give the device 50 milliseconds to drain its queues when
> opening the device, but dies it naively by simply sleeping in open handler,

I've changed 'dies' to 'does' :) and applied, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

