Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F221C4361B
	for <linux-input@archiver.kernel.org>; Mon, 14 Dec 2020 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6FC224B0
	for <linux-input@archiver.kernel.org>; Mon, 14 Dec 2020 00:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437060AbgLNA4c (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Dec 2020 19:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLNA4c (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Dec 2020 19:56:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6CC0613CF;
        Sun, 13 Dec 2020 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OzA8ZmH410IS5TUTQYea10UZnrXgcMpjSkJpxo79qkk=; b=PmdAqCk4n3vHgf985Qx76TJN4X
        Ygx5VG+PYPUL960O/BCNxjmSHfOVJQpmMr7jwhF9Cd+A97GB+eBBabuchmdtrAhG23h3LWvkBrgX5
        pzH5ldje88214c0P+RtUY6xs53hpLxDQnFMlUnfiVKzRzO5hnSt83sj8zy7spWguU0lccIy4B8v1P
        KwQ7arAiRDaAPQ9Jsx0j+nESenDsU2wqen/oN8cdAaCppz6XQTyjRpOpe55PdDKhfx3XqCYzUZplY
        u/ALtJpp3jFmd7iH+7cU5PY4tNpDYt97iUYQTl/z3d6Yt0wjoFYcu+OmpNO6E4W9yLfXmbpuNUb8X
        E+Jzm5YA==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koc9V-0004yv-RQ; Mon, 14 Dec 2020 00:55:50 +0000
Subject: Re: [PATCH 2/8] Documentation: HID: amd-sfh-hid editing & corrections
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20201204062022.5095-1-rdunlap@infradead.org>
 <20201204062022.5095-3-rdunlap@infradead.org>
 <20201205171247.5225d844@archlinux>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0264d355-818f-ea2f-97a1-85663d5ce81c@infradead.org>
Date:   Sun, 13 Dec 2020 16:55:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201205171247.5225d844@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 12/5/20 9:12 AM, Jonathan Cameron wrote:
> On Thu,  3 Dec 2020 22:20:16 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Do basic editing & correction to amd-sfh-hid.rst:
>> - fix punctuation
>> - use HID instead of hid consistently
>> - fix grammar, verb tense

Hi Jonathan,

Thanks for all the comments.
I'll send a v2.


-- 
~Randy

