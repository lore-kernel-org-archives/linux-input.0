Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE9C433E6
	for <linux-input@archiver.kernel.org>; Sun, 21 Feb 2021 01:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D36064D74
	for <linux-input@archiver.kernel.org>; Sun, 21 Feb 2021 01:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUBsQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 20 Feb 2021 20:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBUBsD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Feb 2021 20:48:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 577D264D74;
        Sun, 21 Feb 2021 01:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613872042;
        bh=Ii6mCKLdMk+Svk1KpodaVpXsreuwHJe163Dne4id3BY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VgS2QXFQcNEfGKsPwB2Ue4AjwOHnpRB271Zff+SWfCtYHJX0MGsKzqEYjiHW7GNyu
         9UWD0rznMUif785Ei4KuJUYNVsKJqZNzWgiI3gwEWuD07P6JxE8EjdZd7Zmc10hdGR
         jaJH+54+rAWsGiieIrvINIQuaJB/IHIUZK2g9B1xCNlJ35tRSChJKIEkjtEPfN7ew2
         HNCoMRrPftW2PWoN1ty9jpQKY3Z4uGr110+Oty4h8GATZXKc94jFI/VIcU/VkIsFKB
         la6q40TCW/RF2skPFM3WuY4bqXzkg8ZrIYTfqkA1tSkaw168UHSJVCF+ECmwcY9EZE
         eMzJLoEEFbFsQ==
Date:   Sun, 21 Feb 2021 02:47:19 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] HID: elan: Remove elan_mute_led_get_brigtness()
Message-ID: <20210221024719.101eea98@kernel.org>
In-Reply-To: <20210220163211.323178-3-hdegoede@redhat.com>
References: <20210220163211.323178-1-hdegoede@redhat.com>
        <20210220163211.323178-3-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
