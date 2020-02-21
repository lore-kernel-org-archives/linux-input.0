Return-Path: <SRS0=vEFK=4J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B9C35646
	for <linux-input@archiver.kernel.org>; Fri, 21 Feb 2020 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A42073A
	for <linux-input@archiver.kernel.org>; Fri, 21 Feb 2020 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582289277;
	bh=IjGS++0eyMo56akWPTSH0jQLlkTZPME/xQRqFwkYxEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=qLSMt/uKwzmbY3zsHTyY1sn4OaJ82Q0EyOi9MpV80f8xl39IEsYx5Udr2KVVhkwfG
	 LLEFvyChSbptzme2H/KPcYzHps9OOqgjsr5mKvSMnyi5wJb0ollbAWEElVaTbcvmOM
	 70YtnjiROUuBzebtBTUDmj9BAtpXdGzrz+MA/aUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBUMrx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBUMrv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Feb 2020 07:47:51 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01532073A;
        Fri, 21 Feb 2020 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582289270;
        bh=IjGS++0eyMo56akWPTSH0jQLlkTZPME/xQRqFwkYxEU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yN0iLx15+zPqqBUBgZMkMjooRfOh33CVkPjS/hK2tYcHXIz7cqVO5MIdFReWGEA8X
         shVPME33fsj4D3VFw5+Rz9CXkTI7y6N/VC5MtHhlSiYqAkOL91/pVuxwVJVuu8Muos
         ioP3HK5GesdNg5E85FBKy66nEGqnT8/zrMcjzJfQ=
Date:   Fri, 21 Feb 2020 13:47:38 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
In-Reply-To: <79506ad3-5172-be36-cecc-19d97bfa8b36@amd.com>
Message-ID: <nycvar.YFH.7.76.2002211346070.13129@cbobk.fhfr.pm>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com> <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com> <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com> <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
 <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com> <CAO-hwJJj8uHVr_BTG0rcBchiEttuQTr7ovrtTQ=Cp5vJ2eeoNg@mail.gmail.com> <79506ad3-5172-be36-cecc-19d97bfa8b36@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 19 Feb 2020, Shah, Nehal-bakulchandra wrote:

> > 2 problems here:
> > - patch 3/5 references this debugfs interface which is only added in 4/5.
> > - you are creating a new sysfs set of file for debug purpose only, but
> > as soon as we start shipping those, some other people will find it
> > more convenient to use that directly instead or IIO, and you won't be
> > able to change anything there.
> >
> > So I would strongly advocate against having this debugfs, and suggest you to:
> > - either keep this debugfs as a downstream patch
> > - either play with eBPF or kprobes to retrieve the same information
> > without changing the kernel.
> >
> > For reference, I recently tried to replicate the hidraw functionality
> > with eBPF[0] without changing the kernel code, and it was working.
> > Well, there was no filtering on the source of the HID event, but
> > still, I got the same data directly from the kernel just by adding
> > instrumentation in a couple of functions.

Wow. Complete eBPF supremacy is really coming shortly apparently :)

> If Jiri is Ok, then we will push the next patch as per suggestion here 
> i.e. taking out debugfs.

I agree with that. Thanks,

-- 
Jiri Kosina
SUSE Labs

