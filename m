Return-Path: <SRS0=KRpH=BA=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CAC433DF
	for <linux-input@archiver.kernel.org>; Tue, 21 Jul 2020 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9039820B1F
	for <linux-input@archiver.kernel.org>; Tue, 21 Jul 2020 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595320062;
	bh=I//y4Qz9IX3t5JUGItlkn56iaw4KzS5UTrB2SAe8gE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rU39jwmughkOM6V3W4JsqjPeLKhKJrwsB+tLmOSDffJwQrj7OcVKOY+QIWvsOfVjC
	 4xNIlpFc8H5Phg7upNoWdz/pyNL7M7kaxC0E0Og8iO856FDOtiLvuERq9PK5qRk7wp
	 l1rvq7GmAYaTg2EOPPVbZXsRPfcXnpXf1ld1VKJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUI1m (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgGUI1l (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Jul 2020 04:27:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CC020714;
        Tue, 21 Jul 2020 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595320061;
        bh=I//y4Qz9IX3t5JUGItlkn56iaw4KzS5UTrB2SAe8gE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ8dhI+wal+AI55W5FodivCmeA2FeWazjf13Whvz4nwT+n98ai3vcEajtLEkooEfm
         MYaweIeafs7EzhiCx0DDNFoEM0BT1F/NJBNlBCGUqptvv3EKrIrZC6vG5RpH4KSa94
         cc+eRTfXXuELKC/3njxKlGn7diDrnEoOoyXLpC/s=
Date:   Tue, 21 Jul 2020 10:27:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v1] usbhid: Fix slab-out-of-bounds
 write in hiddev_ioctl_usage()
Message-ID: <20200721082749.GB1659990@kroah.com>
References: <20200718231218.170730-1-yepeilin.cs@gmail.com>
 <20200720115400.GI2549@kadam>
 <20200720121257.GJ2571@kadam>
 <20200720191656.GA3366@PWN>
 <20200721071637.GK2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721071637.GK2571@kadam>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jul 21, 2020 at 10:16:37AM +0300, Dan Carpenter wrote:
> For some reason the reply-to header on your email is bogus:
> 
> Reply-To: 20200720121257.GJ2571@kadam
> 
> "kadam" is a system on my home network.

That's your message-id :)

