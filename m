Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E66CE7A88
	for <linux-input@archiver.kernel.org>; Sat, 23 Sep 2023 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIWXVi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 23 Sep 2023 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIWXVh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 23 Sep 2023 19:21:37 -0400
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Sep 2023 16:21:31 PDT
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DA127
        for <linux-input@vger.kernel.org>; Sat, 23 Sep 2023 16:21:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
        s=key1; t=1695510937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uRl1ixYaY0Cpi2uIWGZyIKgL5GwL4twvNO8Ic4FyQA=;
        b=OmWQJ+aYfCmtK/4yAEmO2L/rjBRLJIsGYitOBfDiFnUCwyIoje8MOaz8m+nNGINMNUM/25
        aSBpiFOhe5IOwtmD9r6H9pJqS1Kmze4/g6/W3ZlVGGEtdMquXa1IqV3Qo9HsIrr17ogpDj
        VSto72lNtmc+Pz5VEFNfevig6P+rudY=
From:   Mikhail Khvainitski <me@khvoinitsky.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikhail Khvainitski <me@khvoinitsky.org>
Subject: Re: [PATCH] HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd
Date:   Sun, 24 Sep 2023 01:58:29 +0300
Message-ID: <20230923231522.94060-1-me@khvoinitsky.org>
In-Reply-To: <20230918145042.37368-1-me@khvoinitsky.org>
References: <20230918145042.37368-1-me@khvoinitsky.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


So, while I was waiting for the review of the patch, I've come up with
much better idea: we can just autodetect if stock and buggy or
patched and bug-free firmware is used and have no need to introduce
additional sysfs knob. So the patch which implements this follows in
the next message.

While the patch is ready to be merged as is (of course, if there are
no comments from reviewers), I thought about the following: may be we
should add a message to dmesg upon detecting stock and buggy firmware
that user should consider patching the firmware? If so, what is the
best place to put an instruction to? Post a link to dmesg? Can the
link point directly to Dennis' blog or its better to put it somewhere
else (with credits, of course)?

Thanks.

