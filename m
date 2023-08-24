Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4659C27C40
	for <linux-input@archiver.kernel.org>; Thu, 24 Aug 2023 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjHXJEH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Aug 2023 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjHXJEB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2023 05:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616B1705
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2023 02:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2510667F1
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2023 09:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68FAC433C7;
        Thu, 24 Aug 2023 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867839;
        bh=dD1rliENUlnzxycjAEIFOmgTqKN5cSOOm68YcZszyUk=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=osHEax2fcK3YT92m6ABtNjNhe6y5fdX5eOuC3LoASlu7l+zC20pFAdYbIbTmewlJ1
         0URKesyuHOL7S7cbagp0k6862JLRkeq9nsjrjK9N4ebsNGyEDvUd0lfTsfentD9lm+
         NHwkzqReORtFBoshps/pem47QQaYg0AbF8fQLpwZRxY0vKvAxLLYPWd7pYZgLkzO60
         LnLcikYcqlIH45UV3Q2rkAxy7SbqxJbdQswuSu74PJlEAz/yn/bq2aaifkndParznw
         YJ/zHSDz41f/lTsiqVOJeYWG2IEJUvHR+255/rpXm4LwSv+mnqaRhitwWucrGV3rhI
         F4qqKH0jTHM5w==
Message-ID: <0095bdc09f016b9bcbd60d837d70d024.mripard@kernel.org>
Date:   Thu, 24 Aug 2023 09:03:56 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Rahul Rameshbabu" <sergeantsagara@protonmail.com>
Subject: Re: [PATCH HID 0/3] Fix devm references used in HID drivers when
 allocating input_dev name
In-Reply-To: <20230824061308.222021-1-sergeantsagara@protonmail.com>
References: <20230824061308.222021-1-sergeantsagara@protonmail.com>
Cc:     linux-input@vger.kernel.org,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 24 Aug 2023 06:13:52 +0000, Rahul Rameshbabu wrote:
> Maxime Ripard analyzed the following situation involving a use-after-free=
 caused
> by incorrect devres management.
>=20
>   1. input_dev name allocated as a resource referring to the same input_d=
ev
>      instance
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
