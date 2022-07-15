Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE1CCA47C
	for <linux-input@archiver.kernel.org>; Fri, 15 Jul 2022 05:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiGOFCu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGOFCt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Jul 2022 01:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E62785AB;
        Thu, 14 Jul 2022 22:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7C362249;
        Fri, 15 Jul 2022 05:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E52AC34115;
        Fri, 15 Jul 2022 05:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657861367;
        bh=f/5S7j85bEKBE91idgnrgzglm4HgCsHJB5pwn12VtrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/Gl4TDHUKMUwFwQH8e/Wl4M7cHuVcSKMUgbKSu/PF5f/UKlM/hv+788XcFc4YMzl
         tGOx8o2+eC+3t3mj/Ms2ul6LmyrU2ziMzkLMCB1jvjVWPNxFhx9S+ufKxMMzHcz1ED
         j92zkdbYNKdzz/MGMQ3iALoS5JC33f6R7Vt/fB1M=
Date:   Fri, 15 Jul 2022 07:02:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 12/23] HID: initial BPF implementation
Message-ID: <YtD09KwkxvJAbgCy@kroah.com>
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-13-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712145850.599666-13-benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jul 12, 2022 at 04:58:39PM +0200, Benjamin Tissoires wrote:
> --- /dev/null
> +++ b/drivers/hid/bpf/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "HID-BPF support"
> +	#depends on x86_64
> +
> +config HID_BPF
> +	bool "HID-BPF support"
> +	default y

Things are only default y if you can't boot your machine without it.
Perhaps just mirror what HID is to start with and do not select HID?

> +	depends on BPF && BPF_SYSCALL
> +	select HID

select is rough, why not depend?


thanks,

greg k-
