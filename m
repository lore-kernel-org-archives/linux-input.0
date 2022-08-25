Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A4BC04AA5
	for <linux-input@archiver.kernel.org>; Thu, 25 Aug 2022 08:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiHYIhA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHYIg7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Aug 2022 04:36:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DAA6C61;
        Thu, 25 Aug 2022 01:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88526B82774;
        Thu, 25 Aug 2022 08:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A433FC433C1;
        Thu, 25 Aug 2022 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661416616;
        bh=j0h6ZC8RVnAOGZdCj+faoK4CHiXFBMsVzZ/ePBxxhKA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=clNXaZtPNdzTE0s44XiJ0uQiwHWhJyOnLaCoytKvDkEP3+Uvrt0uZ+9vPBCcQQRb4
         gD5hS5zJSSpFnNg9MvC2yaLlrx1nXxeg09hqaWuucpaEKWETe8Q9nByQpnsZ1GUVkB
         5eNNiQ6tABC+uZ2mtn7Fwc1WI+l5hGXcL6ygxJoQULnO7SKzf7l9CB1UrkIBVv4iru
         IYd61/HgqF46wVP6HGS7U7xaxgXiiDXoka/AgCW+1GBAkBSj1MK597qVjex3JYMxEy
         EexFXHGpT4N2YG1VZ2IWe0XZWhHCsiDY3KLIuXS4e2IGJ6agoleaOqiGhC2bXktdHx
         5P7LYCOxOEQ+w==
Date:   Thu, 25 Aug 2022 10:36:52 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: playstation: convert to use dev_groups
In-Reply-To: <CAEc3jaApj_=eEgOWzhfh06PXKU7DO1zAsR8tG-SD3vva5duTtw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2208251036290.19850@cbobk.fhfr.pm>
References: <20220804113052.1117009-1-gregkh@linuxfoundation.org> <CAEc3jaApj_=eEgOWzhfh06PXKU7DO1zAsR8tG-SD3vva5duTtw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 12 Aug 2022, Roderick Colenbrander wrote:

> Hi Greg,
> 
> Thanks for the patch. It looks good and confirmed it working properly.
> (Replying from personal email... corporate email systems *Exchange*
> don't work well with GIT)
> 
> Acked-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Sorry for the delay, was off for a bit. Queued in for-6.1/sony.

Thanks,

-- 
Jiri Kosina
SUSE Labs

