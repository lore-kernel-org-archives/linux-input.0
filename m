Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43888C04AA5
	for <linux-input@archiver.kernel.org>; Thu, 25 Aug 2022 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiHYJlU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiHYJlT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Aug 2022 05:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A119568B;
        Thu, 25 Aug 2022 02:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920A461BFE;
        Thu, 25 Aug 2022 09:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8811BC433D6;
        Thu, 25 Aug 2022 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420478;
        bh=XFh01vylxJ2iCCBykFVCgBvHndTHp0d5+Hq0Qjs6lV4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A9RCeiu86nlf1sPFXjqStVW3sOvuThVPb2HuDIs8pSsYk+KgCyym+CqA/igEzkfoT
         0IlZZNkeRObFOVbNqM74sWFVr1qIF2l5gRbkYV5CK0621GE7yekuPCuckGHuCYs2Kj
         pJwUB4uKjORo97ha6jqLzF3HPvNDqFkRomCmgFW8hAjvszpDBaslIcnEjsbzsIRXpl
         J+qX+yjbfEva7I0Boyhm9UWzj+VJLdXYZtrvkvK+ijuoCHA3xWNCyYgIDT63nGHudC
         HPpzRWmbCRfqNwdiQwcBcsQZdojkkJOmm2tEKkFIsXfXT0K3exlZKHS5GCUQ1mAgpP
         NocJPCP7Ztwfg==
Date:   Thu, 25 Aug 2022 11:41:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: Add support for USI style events
In-Reply-To: <20220812103519.2142290-1-tero.kristo@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2208251140420.19850@cbobk.fhfr.pm>
References: <20220812103519.2142290-1-tero.kristo@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 12 Aug 2022, Tero Kristo wrote:

> Add support for Universal Stylus Interface (USI) style events to the HID
> input layers. The events are mapped as follows:
> 
> type	id	event
> ----	--	-----
> MSC(4)	6	Pen ID
> MSC(4)	7	Pen Color
> MSC(4)	8	Pen Line Style Ink
> MSC(4)	9	Pen Line Style Pencil
> MSC(4)	0xa	Pen Line Style Highlighter
> MSC(4)	0xb	Pen Line Style Chisel Marker
> MSC(4)	0xc	Pen Line Style Brush
> MSC(4)	0xd	Pen No Preferred Line Style
> ABS(3)	0x1c	Pen Line Width
> 
> All the listed MSC events are new, the ABS one is mapped to an existing
> event.

Dmitry, could you please Ack the MSC_PEN_* additions?

Thanks,

-- 
Jiri Kosina
SUSE Labs

