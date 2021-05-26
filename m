Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BAC47082
	for <linux-input@archiver.kernel.org>; Wed, 26 May 2021 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BE613D8
	for <linux-input@archiver.kernel.org>; Wed, 26 May 2021 10:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhEZKvG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 May 2021 06:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhEZKvF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 May 2021 06:51:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFD26023D;
        Wed, 26 May 2021 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622026173;
        bh=1UmwkhMDUasdphU3uCe7yFZsBFFDdjtrmpQ46DdPFfU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=W6AL7K6qu5LgOaIhUrT9sbplYaG3VAttvpC8p0D+c/1v7tCq4fyR6vv8RXqou2fm+
         C1ZGkpdJ4xfcBYFJ0JpW/ICP2u3aIlG9vhBkRt88UhVKqBLu6hKRLEtKE9kxkGitmv
         0fWguVn+0Gi0Zj8nJOOV1/aDFmWnXXpkXo85ow5F73ULzbfRMvlaLcp3Pq6aIeI4F4
         ZJouvvdvxIuNQbtTNUAeRpXCpLh2hJCV+tkS4Qy2ceyhHvjxu2QYBG780UNdmAvHgE
         dOpmrtjyXkyE8vy8EIsdpmrWRacXIcIiaoCN8b1Lqz8hsXteKljE/KSkN7vG+omx2L
         KE5D6eaVRp/yg==
Date:   Wed, 26 May 2021 12:49:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Add Alder Lake device IDs
In-Reply-To: <20210517063609.23267-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2105261249230.28378@cbobk.fhfr.pm>
References: <20210517063609.23267-1-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 17 May 2021, Ye Xiang wrote:

> Add Alder Lake PCI device IDs to the supported device list.

Applied.

-- 
Jiri Kosina
SUSE Labs

