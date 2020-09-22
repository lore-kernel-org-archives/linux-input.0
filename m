Return-Path: <SRS0=uQL6=C7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F8C4346E
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FF72193E
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 02:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600742122;
	bh=3MgUw8675/kbmfSGD0oscui8OSQisSWDE3fsdVyPj8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBbYAQlTfosJC0K5j++Z46GjW3ZKuhCBYfZu3G2AQO/Z6Av8Dr8f0g2R2enaroXMS
	 eS0t9Qtw/+18/+9W8WTdg8cFDEMYtloSdnU2g3E8zX4C3YR9SEO/d2FF8nnjRSjbmQ
	 QKL6e1Mfpu3lnkBq9loq84UwzMUZAKOv1MEGy+HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgIVCfS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbgIVCfS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Sep 2020 22:35:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59282207C4;
        Tue, 22 Sep 2020 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600742117;
        bh=3MgUw8675/kbmfSGD0oscui8OSQisSWDE3fsdVyPj8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YD1+2S8WeiLmCUVs+URFky1KpVdJsW4jbjAVBrXhz6+Y8mGtKhGRN4sWfJiw4wtf1
         fJ7fKHqfJX7sQHrfvzwdcI7J5O57XZOaEg/Glawa6QZ1W+EIYk1keIcHFQfeWWoLg5
         2b85v0D3zCdOWVSaMFHD5i8VBD6cqMXW5I2sFQ0o=
Date:   Tue, 22 Sep 2020 10:35:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: imx6ul_tsc - unify open/close and PM paths
Message-ID: <20200922023504.GW25109@dragon>
References: <20200914175042.GA1497032@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914175042.GA1497032@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Sep 14, 2020 at 10:50:42AM -0700, Dmitry Torokhov wrote:
> Open/close and resume/suspend paths are very similar, let's factor out
> common parts.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
