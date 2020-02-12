Return-Path: <SRS0=6nV4=4A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F8C2BA83
	for <linux-input@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5546E20724
	for <linux-input@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581515052;
	bh=XclT0NkWykbM9tsCcE016eWt/DimSeDtX1amLj4wQ8c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=jdcadUDb4onSUEyzT6F0IT1N5LMocEAwPIcrzEKncM2UJzaP2FBor5ZTbbaZfwZjg
	 2tDlXcgq/ShoyN6jOHcywdkgVD6jGds7pfGFVNFOWn/Vvo3m3W5aLy9Pr+HuE96xY6
	 Rm6HcmOh33IiUsW7/1gZy/hddssqv9AR7RsihMSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBLNoM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:44:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgBLNoL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Feb 2020 08:44:11 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD6520659;
        Wed, 12 Feb 2020 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581515051;
        bh=XclT0NkWykbM9tsCcE016eWt/DimSeDtX1amLj4wQ8c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2wPi/r7rV7jT8+eR2wRFthO5/iwvQpbvlvNXev3t3JpjBQRN2yed0Wv1VHznDNBXH
         3CZ8jgmEByOkhZZvAhFc9FhO4rDsA20yOdIxMFmNiZhZXTQeT8kBJch7rV14OYF5LM
         JOJ/70btQSuMh795q8Y2s9DMDBi31QOtzKFF3xO8=
Date:   Wed, 12 Feb 2020 14:44:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v2] HID: logitech: drop outdated references to unifying
 receivers
In-Reply-To: <20200112235009.4074405-1-lains@archlinux.org>
Message-ID: <nycvar.YFH.7.76.2002121443140.3144@cbobk.fhfr.pm>
References: <20200112235009.4074405-1-lains@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 12 Jan 2020, Filipe Laíns wrote:

> The hid-logitech-{dj,hidpp} were originally developed for unifying
> receivers but since then they have evolved and now support other types
> of receivers and devices. This patch adjusts the original descriptions
> with this in mind.

[ CCing Nestor ]

Benjamin, Nestor, can I please get your Ack (as authors of the original 
code)?

Thanks,

-- 
Jiri Kosina
SUSE Labs

