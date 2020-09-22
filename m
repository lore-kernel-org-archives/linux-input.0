Return-Path: <SRS0=uQL6=C7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EBC2D0E2
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A8520C09
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600766219;
	bh=/qNykw9P1hkPLZ7BGgDNtx9D92tn1ua/Mb2jUA9yNek=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=mxwGdAKVLJQoT8+fkl1rIifqUrHrFY2o55Zw9mhe47S70OygfD9zjQttjaH5h8hga
	 SROuBJUNrsY0DLwMcsahummA4jjhUz3+0RoWNEVO3YjpdDuv4BPoMZZTT3mjcqNkkp
	 2jiAhxhVThzLV51INygM/5o9Hd3jQIgXEYjvMA5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVJQ7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgIVJQ7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Sep 2020 05:16:59 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D739A2075E;
        Tue, 22 Sep 2020 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600766218;
        bh=/qNykw9P1hkPLZ7BGgDNtx9D92tn1ua/Mb2jUA9yNek=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cNdgaUxacaIdBGEElGxj0o/ZygTWBwcijGegTBzUYvYCXb50qdm/6DVXoIPwsS21h
         Bowxjzx/aLI6+Ul6ZuTVT5IkBnuznadvS1xeq63n9NiCE+sOyqXA6o72SOy2nROG5E
         OrJ3ouoAWGPqSPPolmUQOF8M/ntxDbAodlF95dd4=
Date:   Tue, 22 Sep 2020 11:16:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Mikael_Wikstr=F6m?= <leakim.wikstrom@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and
 buttons
In-Reply-To: <CADGsf-Gs9EM770jTVX=yABBLAT1rdfBYb5jam720yqez=D3VHg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2009221115530.3336@cbobk.fhfr.pm>
References: <CADGsf-Gs9EM770jTVX=yABBLAT1rdfBYb5jam720yqez=D3VHg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 19 Sep 2020, Mikael Wikström wrote:

> One more device that needs 40d5bb87 to resolve regression for the trackpoint
> and three mouse buttons on the type cover of the Lenovo X1 Tablet Gen3.
> 
> It is probably also needed for the Lenovo X1 Tablet Gen2 with PID 0x60a3
> 
> Signed-off-by: Mikael Wikström <leakim.wikstrom@gmail.com>

Thanks for the patch. Unfortunately it has been whitespace damaged by your 
client. Could you please fix that up (some help might be found in [1]) and 
resubmit?

Thanks.

[1] Documentation/process/email-clients.rst

-- 
Jiri Kosina
SUSE Labs

