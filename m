Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D21C433E0
	for <linux-input@archiver.kernel.org>; Thu, 28 Jan 2021 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F95864DCC
	for <linux-input@archiver.kernel.org>; Thu, 28 Jan 2021 11:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhA1LKB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:10:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2442 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhA1LJ7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Jan 2021 06:09:59 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DRHhN5xclz67hBF;
        Thu, 28 Jan 2021 19:05:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 12:09:17 +0100
Received: from localhost (10.47.74.140) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 28 Jan
 2021 11:09:17 +0000
Date:   Thu, 28 Jan 2021 11:08:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linuxarm]  Re: [PATCH v3 00/12] add IRQF_NO_AUTOEN for
 request_irq
Message-ID: <20210128110833.00000c43@Huawei.com>
In-Reply-To: <YBHC6SzXAOSNoQnI@google.com>
References: <20210107223926.35284-1-song.bao.hua@hisilicon.com>
        <848fb07c3073401bbbe15db71f5922c9@hisilicon.com>
        <YBFvYStmGeChUJlO@kroah.com>
        <YBHC6SzXAOSNoQnI@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.140]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 27 Jan 2021 11:45:45 -0800
"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com> wrote:

> On Wed, Jan 27, 2021 at 02:49:21PM +0100, gregkh@linuxfoundation.org wrote:
> > On Thu, Jan 21, 2021 at 09:38:28PM +0000, Song Bao Hua (Barry Song) wrote:  
> > > Hi Thomas, Greg, Dmitry, Marc,
> > > Any further comment on this new API?   
> > 
> > It's not my subsystem, I'll let the irq maintainers handle it :)  
> 
> Not my subsystem either, but I would like to have this feature
> available. I do not like calling irq_set_status_flags() before
> request_irq() as at that time we are not ensured of irq ownership, and
> using disable_irq() afterwards is indeed awkward.
> 

Likewise, keen on having this available.

Jonathan

> Thanks.
> 

