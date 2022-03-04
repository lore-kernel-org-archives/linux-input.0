Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2513C433FE
	for <linux-input@archiver.kernel.org>; Fri,  4 Mar 2022 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiCDShV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCDShU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2022 13:37:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70A1D5290;
        Fri,  4 Mar 2022 10:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D1D6B827E6;
        Fri,  4 Mar 2022 18:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A3CC340E9;
        Fri,  4 Mar 2022 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646418990;
        bh=jStB8DXDHaCuBXHiFAKklIssYKXzmP1NPQypXlcYYag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJ2Ke1ERSEbuahQSyoTWY4H6FXAaYBsljkD7RC+yQ91GHDNM73J1A2E6Iy74Din43
         Nr4OBLxIj2Fty5DQzxZwPuLBSXdS5TZ7IAA+ohR1qshi1ejg+Km59/bID3R4Wkdag8
         CEjwvkCxFIPLWiiXowZrEOek8GzviwndzJdeHXls=
Date:   Fri, 4 Mar 2022 19:36:18 +0100
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
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 11/28] samples/bpf: add a report descriptor
 fixup
Message-ID: <YiJcIso43MWFUcMp@kroah.com>
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-12-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304172852.274126-12-benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Mar 04, 2022 at 06:28:35PM +0100, Benjamin Tissoires wrote:
> the program inverts the definition of X and Y at a given place in the
> report descriptor of my mouse.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> changes in v2:
> - split the series by bpf/libbpf/hid/selftests and samples
> ---
>  samples/bpf/hid_mouse_kern.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/samples/bpf/hid_mouse_kern.c b/samples/bpf/hid_mouse_kern.c
> index c24a12e06b40..958820caaf5d 100644
> --- a/samples/bpf/hid_mouse_kern.c
> +++ b/samples/bpf/hid_mouse_kern.c
> @@ -62,5 +62,30 @@ int hid_x_event(struct hid_bpf_ctx *ctx)
>  	return 0;
>  }
>  
> +SEC("hid/rdesc_fixup")
> +int hid_rdesc_fixup(struct hid_bpf_ctx *ctx)

No comment here to show the same as you put in the changelog saying what
this function is doing?

Otherwise it's hard for a non-HID developer to know that:

> +
> +	ctx->data[39] = 0x31;
> +	ctx->data[41] = 0x30;

Is flipping things.

thanks,

greg k-h
