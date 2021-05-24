Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516ECC04FF3
	for <linux-input@archiver.kernel.org>; Mon, 24 May 2021 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2263261028
	for <linux-input@archiver.kernel.org>; Mon, 24 May 2021 10:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhEXKLL (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 24 May 2021 06:11:11 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33339 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhEXKLC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 May 2021 06:11:02 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4DBA5200004;
        Mon, 24 May 2021 10:09:18 +0000 (UTC)
Message-ID: <3361d24ffb0216f70861f8c882910cd50971b0ca.camel@hadess.net>
Subject: Re: [PATCH] touchscreen/goodix.c:remove no needed commas
From:   Bastien Nocera <hadess@hadess.net>
To:     mateng <ayowoe@163.com>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mateng <mateng@yulong.com>
Date:   Mon, 24 May 2021 12:09:17 +0200
In-Reply-To: <20210524093354.1356-1-ayowoe@163.com>
References: <20210524093354.1356-1-ayowoe@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 2021-05-24 at 17:33 +0800, mateng wrote:
> From: mateng <mateng@yulong.com>
> 
> remove no needed commas

There's really no reason to be shuffling around commas. This isn't
helpful in the slightest. NAK.

