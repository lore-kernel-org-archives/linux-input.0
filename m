Return-Path: <SRS0=3AEP=62=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB198C54E4A
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18E32078A
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589278516;
	bh=Vra807JstpipO5hypSeIatCfFsLHr5tWZYuOg0SwUgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qYGMsWxcynEf7O1OSDEUsH9YrjcIdJMIJNCeHTdRmHa81a+Mh3fnbltICq+umE+5
	 jkxZalPDJ8S0EolasF2PSAUDs9UNTMNGl4THBp/ahl03BXwzrHzS2c0CWOBJdXcRfG
	 k+APiW/R7n/L1M9h7ZURjtFk08ttW58brMQDJ244=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgELKPP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 May 2020 06:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgELKPO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 May 2020 06:15:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D511920736;
        Tue, 12 May 2020 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589278513;
        bh=Vra807JstpipO5hypSeIatCfFsLHr5tWZYuOg0SwUgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYLii9PrIaxe/0yJIDq7clgcXzvBC3WivUeBpc06aYMyrv1lNPMvP+LDEq5wJ8U47
         wKYAT8w1RFzsAjYFPtaq9B1HnTiHQIrGUSeOH1qxrTnXJOkLb/d9blhLRbcJR6pb/C
         jLHDMivVnA/BYY6EnZ9mSb8uWWkux+8N8SVgIIPM=
Date:   Tue, 12 May 2020 12:15:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrea.Ho@advantech.com.tw,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        voyandrea@gmail.com, amy.shih@advantech.com.tw,
        oakley.ding@advantech.com.tw, HY.Lee@advantech.com.tw
Subject: Re: [V3,1/1] Input/misc: add support for Advantech software defined
 button
Message-ID: <20200512101511.GA3991701@kroah.com>
References: <20200512043149.10719-1-Andrea.Ho@advantech.com.tw>
 <CAK8P3a1gKHir-hVoX_mFzqcOF=9NfM1NqO96kC-=6ZHf6Lojdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1gKHir-hVoX_mFzqcOF=9NfM1NqO96kC-=6ZHf6Lojdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, May 12, 2020 at 12:08:08PM +0200, Arnd Bergmann wrote:
> > +MODULE_LICENSE("GPL");
> 
> These generally go at the bottom of the file.
> 
> The license tag here does not match the one in the SPDX header, after
> you changed the other one to v2-only.

Yes it does, they mean the same thing, see modules.h for the details if
you are curious.

thanks,

greg k-h
