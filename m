Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B3C433DB
	for <linux-input@archiver.kernel.org>; Sun, 21 Feb 2021 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DA064F00
	for <linux-input@archiver.kernel.org>; Sun, 21 Feb 2021 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBULbD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 21 Feb 2021 06:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhBULbA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Feb 2021 06:31:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F39464EE6;
        Sun, 21 Feb 2021 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613907020;
        bh=Ii6mCKLdMk+Svk1KpodaVpXsreuwHJe163Dne4id3BY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l+EoKzByXeItptxBFGA1ZcfMthX/fi23wE0xVeVVhothSkRH1ie6DzMSjHqzqNCzF
         rzuxeaOMCsJj0bVr/q8CGMW+HVBJifJrwxNIxAgYIAQMG9gxiP+FKP7mIEne1e/nAw
         4CardLEJXEhZffJdxS6rlVvEj2aEqy+VOO9k9sQevdb2hoj1k6zw9iO7xmJWrybxiG
         M6rozT1DsfVpEwq2uPb7DjVBqjGPIyGyNwLHtFDdF5PiOZ8w/ahWA0WYHAkkN5JKov
         nD3VaCaV7V/h0KA5OraMgYZ3nWouwNZNHGlPb7HQtj40TqszX/xEAPKFBt74iJnJyU
         BiWcbR+6OwHig==
Date:   Sun, 21 Feb 2021 12:30:16 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 6/7] HID: lenovo: Map mic-mute button to KEY_F20
 instead of KEY_MICMUTE
Message-ID: <20210221123016.5f308702@kernel.org>
In-Reply-To: <20210221112005.102116-7-hdegoede@redhat.com>
References: <20210221112005.102116-1-hdegoede@redhat.com>
        <20210221112005.102116-7-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
