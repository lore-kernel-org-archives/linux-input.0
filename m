Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACEC56202
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D817021527
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqN3333F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgKYQls (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 25 Nov 2020 11:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgKYQls (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Nov 2020 11:41:48 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7DF72083E;
        Wed, 25 Nov 2020 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322507;
        bh=hAapsVV7Fn5sf6yEsg6bG66O/E5U39K/2C4JmBWYGIU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MqN3333FJxVFU+2qPy1MDlJ7nWkEHOsg9vJczkDVPY+t37usrzYfakVeH3wE1sOd/
         j0mqniMKWtNB20soKCdPzs0OJlnvslBpXKyJhTEKykeT65glx77m+wWmiAh0QzpJb4
         ZyZ5gwHg9AmjT7uvnMwMvrJfOunmgNKZMsBueB38=
Date:   Wed, 25 Nov 2020 17:41:44 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Takuma YOSHIOKA <lo48576@hard-wi.red>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: elecom: rewrite report based on model specific
 parameters
In-Reply-To: <5d9b0f87-aa61-81af-5274-eaab8b73123f@hard-wi.red>
Message-ID: <nycvar.YFH.7.76.2011251741340.3441@cbobk.fhfr.pm>
References: <20201121205438.4092-1-lo48576@hard-wi.red> <nycvar.YFH.7.76.2011251428240.3441@cbobk.fhfr.pm> <5d9b0f87-aa61-81af-5274-eaab8b73123f@hard-wi.red>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 25 Nov 2020, Takuma YOSHIOKA wrote:

> >  	case USB_DEVICE_ID_ELECOM_M_DT1URBK:
> >  	case USB_DEVICE_ID_ELECOM_M_DT1DRBK:
> >  	case USB_DEVICE_ID_ELECOM_M_HT1URBK:
> >  	case USB_DEVICE_ID_ELECOM_M_HT1DRBK:
> > -		mouse_button_fixup(hdev, rdesc, *rsize, 8);
> > +		/*mouse_button_fixup(hdev, rdesc, *rsize, 13, 15, 21, 31, 8);*/
> 
> I'm very very sorry, I noticed that I've forgotten to remove this commented-out line...
> This "13, 15, 21, 31" line should be removed completely.

No worries, I've dropped that one already. Thanks,

-- 
Jiri Kosina
SUSE Labs

