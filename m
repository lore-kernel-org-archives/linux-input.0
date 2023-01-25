Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D3C27C76
	for <linux-input@archiver.kernel.org>; Wed, 25 Jan 2023 14:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjAYOnF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAYOnE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2023 09:43:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E032D27D4A;
        Wed, 25 Jan 2023 06:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52E7614E8;
        Wed, 25 Jan 2023 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C43DC433D2;
        Wed, 25 Jan 2023 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674657678;
        bh=f0bSOivAmHl0WZMNNqPUhRsJXryAKupiscPEkqGKcEA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BFq2aYwLySPc8sAdSK1OcS6Z5TZKpywPjgFSH698iGmVFiLqvegLz60QH2YELaZPJ
         kWCRloBtwKHFnQ6kmbIg2hZ33uNGMAUQck/uMsC0zA9tm+Og/xhpBqCJhtmrmRUbhC
         bjR3Sw81oQVnKWI8hynOTdjdx16INCwOcVa/nyVgB/PRLVTwI0cTIg51gXvhY76w8T
         Eptt0/ZTX6Y6zE+0UyjRlnVD3hFZ8kI0YSS5/LpgVzVKZAmNXE6e9j7ZBAfbISQ3xJ
         NFcECjXd0xoRIV5z2tuDAxNil7GlaKYZ4FMvM1sREfYSCkcLtvfb+TSmcd5Yn7lSki
         o19l7RSCgxStQ==
Date:   Wed, 25 Jan 2023 15:41:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marco Rodolfi <marco.rodolfi@tuta.io>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: Ignore battery for Elan touchscreen on Asus
 TP420IA
In-Reply-To: <NLR9TEh--3-9@tuta.io>
Message-ID: <nycvar.YFH.7.76.2301251540380.1734@cbobk.fhfr.pm>
References: <NLR9TEh--3-9@tuta.io>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 10 Jan 2023, marco.rodolfi@tuta.io wrote:

> 
> This device has a touchscreen thats report a battery even if it doesn't 
> have one. 
> Ask Linux to ignore the battery so it will not always report it as low. 
>  
> Signed-off-by: Marco Rodolfi <marco.rodolfi@tuta.io> 

Hi Marco,

your patch has been malformed by your mail client. I have fixed it up and 
applied, but please make sure you fix that for your further submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs

