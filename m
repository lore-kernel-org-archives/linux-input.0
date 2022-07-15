Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58139C433EF
	for <linux-input@archiver.kernel.org>; Fri, 15 Jul 2022 05:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGOFBq (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGOFB2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Jul 2022 01:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B478DD0;
        Thu, 14 Jul 2022 22:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA0F6224A;
        Fri, 15 Jul 2022 05:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE19C34115;
        Fri, 15 Jul 2022 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657861281;
        bh=SdL+PpTYFhcwe+vDQoaXChr/y7VoHYAjxVIeSauX34Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeY0HC58dgPGfVe/95XzDdsvM++jj6+XGXEC03MzyZl6XdPQASElqzz8RVM3NKz/0
         /fWVHmztcrHxr+TWSvd/8HqmCvlHro1S1t0dpvYUWYmI/aBfio6sR2s0BH4H1WVsHO
         znkhWzQarRLHYf5m6dlJzRAcsNHBlpyZt1BFyGVU=
Date:   Fri, 15 Jul 2022 07:01:19 +0200
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
Subject: Re: [PATCH bpf-next v6 11/23] HID: convert defines of HID class
 requests into a proper enum
Message-ID: <YtD0n0+VDzRzEmA/@kroah.com>
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-12-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712145850.599666-12-benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jul 12, 2022 at 04:58:38PM +0200, Benjamin Tissoires wrote:
> This allows to export the type in BTF and so in the automatically
> generated vmlinux.h. It will also add some static checks on the users
> when we change the ll driver API (see not below).
> 
> Note that we need to also do change in the ll_driver API, but given
> that this will have a wider impact outside of this tree, we leave this
> as a TODO for the future.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
