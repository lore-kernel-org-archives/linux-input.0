Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135BC4332F
	for <linux-input@archiver.kernel.org>; Mon,  6 Nov 2023 06:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKFGRQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFGRP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Nov 2023 01:17:15 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B1DB
        for <linux-input@vger.kernel.org>; Sun,  5 Nov 2023 22:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699251428; x=1699510628;
        bh=I/NADm3y4JRhxPmSbj3v0umXGT2ZrmOBF5vX4lVtFkA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N1zInv7T/pcD6sBuNdVTKrruTrhFcEE2FbHE/yjdtzonYQm0fLTwS2vvsgvvRSj4x
         vdG7v/grIykNsjEbEoLgA1vCwsmqKLMRNWci2d/GVpHvXHybExbICVHxwRMB7rFjy6
         fB5+DjF6NB+pjiDkhmStITYfKRUftKht+mLjsTKxQJTrVM3QjsxMVFy9JKdTmS9KyY
         s4E0yStEKblp8Zr61j5IqRymQz8d8HQnYTdnOO6yh9WLPZSmuhH7MDsr0jGgrqQ57U
         vQNqd9k8tLeNAhhG7kctPi61o9Y/mHJw2ODxOW5aCnn9APIGV9kCYwThiFMqvJLyfy
         N4LNPURNHqIZQ==
Date:   Mon, 06 Nov 2023 06:16:59 +0000
To:     Su Hui <suhui@nfschina.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom_sys: add error code check in wacom_feature_mapping
Message-ID: <87pm0nz9rc.fsf@protonmail.com>
In-Reply-To: <20231106060815.104971-1-suhui@nfschina.com>
References: <20231106060815.104971-1-suhui@nfschina.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 06 Nov, 2023 14:08:16 +0800 "Su Hui" <suhui@nfschina.com> wrote:
> hid_report_raw_event() can return error code like '-ENOMEM' if
> failed, so check 'ret' to make sure all things work fine.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2:
>  - report the returned error (Rahul Rameshbabu) and __func__.

Thanks for the patch. Like the addition of using __func__.

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

