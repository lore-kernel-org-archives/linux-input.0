Return-Path: <SRS0=nOvE=B3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F31FC433DF
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C4E2078A
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597658610;
	bh=wmcaFxW9t9EyLbZL1rgqdfwWy8o4SSHgO9nrDnNXhss=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=H+qtq9PE/1Isxz3ZGj4vEx2CVwzTvhsnWozGRQbnYAeKqg7hvg5KUUfWxbLlVuRrZ
	 FpN8ufN4bhZ371TnKanM4aEKi75WZLD+1NSav+Cbm0yzP+BnbGMVdgotEM4GjlL8fj
	 pcL9Gqoqwx6XxVyhN1LufPkTCZgIkXhsxmmlOfME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHQKD3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHQKD3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Aug 2020 06:03:29 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D025C2072E;
        Mon, 17 Aug 2020 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597658608;
        bh=wmcaFxW9t9EyLbZL1rgqdfwWy8o4SSHgO9nrDnNXhss=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vKUbkJN9QyyriYrHp1s64BeOGVkEOqMgyrJl9ynb98WAgiZqnlzWsZDCU63IOM4mG
         FBWOLKVUaqWS32XH6VltqARsl+ALT+OFfDwUZBxhqzhJUGFdqpyyrx7c8SrPteqGxP
         MUoP0Pk8D1FKyGnLS4QWXfwn8LJnfFENnD+m8AZY=
Date:   Mon, 17 Aug 2020 12:03:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Frank Yang <puilp0502@gmail.com>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Support Varmilo Keyboards' media hotkeys
In-Reply-To: <20200729135341.16799-1-puilp0502@gmail.com>
Message-ID: <nycvar.YFH.7.76.2008171202130.27422@cbobk.fhfr.pm>
References: <20200729135341.16799-1-puilp0502@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 29 Jul 2020, Frank Yang wrote:

> The Varmilo VA104M Keyboard (04b4:07b1, reported as Varmilo Z104M)
> exposes media control hotkeys as a USB HID consumer control device,
> but these keys do not work in the current (5.8-rc1) kernel due to
> the incorrect HID report descriptor. Fix the problem by modifying
> the internal HID report descriptor.
> 
> More specifically, the keyboard report descriptor specifies the
> logical boundary as 572~10754 (0x023c ~ 0x2a02) while the usage
> boundary is specified as 0~10754 (0x00 ~ 0x2a02). This results in an
> incorrect interpretation of input reports, causing inputs to be ignored.
> By setting the Logical Minimum to zero, we align the logical boundary
> with the Usage ID boundary.
> 
> Some notes:
> 
> * There seem to be multiple variants of the VA104M keyboard. This
>   patch specifically targets 04b4:07b1 variant.
> 
> * The device works out-of-the-box on Windows platform with the generic
>   consumer control device driver (hidserv.inf). This suggests that
>   Windows either ignores the Logical Minimum/Logical Maximum or
>   interprets the Usage ID assignment differently from the linux
>   implementation; Maybe there are other devices out there that only
>   works on Windows due to this problem?
> 
> Signed-off-by: Frank Yang <puilp0502@gmail.com>
> ---
>  drivers/hid/Kconfig       |  6 ++++
>  drivers/hid/Makefile      |  1 +
>  drivers/hid/hid-ids.h     |  2 ++
>  drivers/hid/hid-varmilo.c | 58 +++++++++++++++++++++++++++++++++++++++

Hi Frank,

thanks for the patch.

Given the fact that the device presents itself with CYPRESS VID (0x04b4, 
'officially' assigned to cypress), can we avoid creating extra driver, and 
rather extend hid-cypress.c with this quirk, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

