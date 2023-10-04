Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D597E7B61F
	for <linux-input@archiver.kernel.org>; Wed,  4 Oct 2023 19:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbjJDTEx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbjJDTD3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Oct 2023 15:03:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E78618D;
        Wed,  4 Oct 2023 11:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C37C433C9;
        Wed,  4 Oct 2023 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445915;
        bh=tq7NZFlnZHqJn3BR7loczaVqdjig92RJVIObjwVIOys=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jHIH1Tyn86fi7HJ9R68SYq3FokwFMukaSVyE6JHrGJt/2Zw6AbBcl/kvKVEkjwIUz
         PhPPGd/6diC/Z1PZuK89LdT8P4Q5P8X7zfUGxGUs5bRKwgkjpLFh/MxdrVBZETgnaW
         IYjoeBHoulD3NmJQhnRMnyiPVC/F8Tufgn1BC07yrpFR830JiC4mG4TH4qxM8abQAr
         MZ9/0NDyuvF0N+qSDtgqtg6I6Ec+cLaf+pIYcO55Zw0077wbLXWsLfvS6hMQ6mFMLa
         Ov6l5L7uj2JQbNMF7kBWdqteIAJh+f9uinwmPhzsekZyN0esobhjjMC52ZuKr4rCRC
         3kYcDXI+coQGg==
Date:   Wed, 4 Oct 2023 20:58:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] HID: nvidia-shield: Fix the error handling path
 of shield_probe()
In-Reply-To: <20230918115432.30076-1-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2310042058000.3534@cbobk.fhfr.pm>
References: <20230918115432.30076-1-rrameshbabu@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 18 Sep 2023, Rahul Rameshbabu wrote:

> This series fixes some missing clean-up function calls in the error handling of
> the probe.
> 
> Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
> patches)
> 
> Patch 3 is an enhancement that creates a common function for cleaning up
> thunderstrike instances.
> 
> Changes:
> 
>   v1->v2:
>     - Add the LED_RETAIN_AT_SHUTDOWN flag to prevent
>       led_classdev_unregister from trying to set the LED to off before a
>       successful call to hid_hw_start.
>     - Rename err_haptics label to err_ts_create to make the label name more
>       accurate.
>     - Re-order operations in thunderstrike_destroy to be in LIFO order with
>       regards to the operations in thunderstrike_create.
>   v2->v3:
>     - Refactor thunderstrike_destroy to take a thunderstrike instance
>       pointer as a parameter and prevent a variable from being unused
>       in shield_probe.
> 
> Link: https://lore.kernel.org/linux-input/cover.1693070958.git.christophe.jaillet@wanadoo.fr/
> Link: https://lore.kernel.org/linux-input/20230918041345.59859-1-rrameshbabu@nvidia.com/
> 
> Notes from Rahul:
>   - Thank you so much Christophe for these patches.
>   - Sent v2 without accounting for the fact that thunderstrike_destroy in v1
>     makes the thunderstrike instance in shield_probe unused. Tested v3 with W=1.
> 
> Christophe JAILLET (3):
>   HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>     probe error handling path
>   HID: nvidia-shield: Fix some missing function calls() in the probe
>     error handling path
>   HID: nvidia-shield: Introduce thunderstrike_destroy()

I have applied 1/3 and 2/3 to for-6.6/upstream-fixes and 3/3 to 
for-6.7/nvidia-shield.

Thanks,

-- 
Jiri Kosina
SUSE Labs

