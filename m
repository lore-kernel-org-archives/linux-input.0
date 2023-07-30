Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1028C001DF
	for <linux-input@archiver.kernel.org>; Sun, 30 Jul 2023 13:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG3NCI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 30 Jul 2023 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3NCH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Jul 2023 09:02:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAA1AE;
        Sun, 30 Jul 2023 06:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F0560C34;
        Sun, 30 Jul 2023 13:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF5C433C7;
        Sun, 30 Jul 2023 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690722126;
        bh=HkBskomY64Ev5J2EbXQPFbdqgVV6hfk9ifCbvd9sVxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMvtjkW3gNuTOidDtvPW4GS6/CGkaXLvax+fj+gHpYbW3YNKKrZXu34dXDZG0uZqU
         OURMUYEml22Fx1y5cmy8afdUhLw0yX4vRMOO4xVnFIX8blm3r2xcuk9wGIG10fYHyG
         tL4JxFBnrgqVS+F1jdl1BySuJ8YLpCBVesT1svP28poXlzUOeAOGMxK/tu9TlnUqSZ
         Hg9DBccgEZP6ebJX5w6uQS1QfnW0bGKWb2wpVb2cXH+enz2mN/f0wQ1zC/gLznClR+
         MMEL7oylnqYYcIpAX6DHLLWvG6FDxFGeui84T7RVHCeVXPNIo0O09cscDysYopIq/B
         /lQ6vPVwXAMiQ==
Date:   Sun, 30 Jul 2023 15:02:02 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH 20/22] Input: stmfts - use device core to create
 driver-specific device attributes
Message-ID: <20230730130202.pmnxus5mucwu6bom@intel.intel>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-20-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729005133.1095051-20-dmitry.torokhov@gmail.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, Jul 28, 2023 at 05:51:29PM -0700, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
