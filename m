Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA81EB64DC
	for <linux-input@archiver.kernel.org>; Mon, 10 Jul 2023 08:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGJIdW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 10 Jul 2023 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjGJIdA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2023 04:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0524CE6A;
        Mon, 10 Jul 2023 01:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B0960F04;
        Mon, 10 Jul 2023 08:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1E4C433CB;
        Mon, 10 Jul 2023 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977967;
        bh=RWqXVmbCkD0zxeg5+q+W4tm1/y5wQWtRN+u2j/wCPgE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ClPJ3O4/7s3AcvKHCCOLJhilECYfMBYdKSsRs5AtawvoQEbvRyNNy4XIIZY7at+va
         y+fkTUUOaEGOG0s5dnC3BDHWalioXGj55TvKUs+tjC0UZ1QifPqRfpJbK/opVH15xd
         SzFiC/sggRnVoWFqt6iCvsHZ7bMKtT6+1xtTQ5y0dATXguA6nZdZcPzBfPtzBZurGI
         EFkGrcgj89BNR/uRJwKgLYvVw9Xlvuhq8V1DM5+fMisUMUBPqYS6JNEvnv1obvaktP
         S5Edw+Ocxu6ToQfWL8HxAoIT1Qb6uzv91x6/bSU1oQ8RjFvsvTcuu4w1fXNWx3QJtq
         /nrXICnp5h62w==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>
In-Reply-To: <20230630113818.13005-1-stuart.a.hayhurst@gmail.com>
References: <20230630113818.13005-1-stuart.a.hayhurst@gmail.com>
Subject: Re: [PATCH v3] HID: logitech-hidpp: Add wired USB id for Logitech
 G502 Lightspeed
Message-Id: <168897796584.315593.11108454722291259760.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 10:32:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 30 Jun 2023 12:38:20 +0100, Stuart Hayhurst wrote:
> Previously, support for the G502 had been attempted in commit
> '27fc32fd9417 ("HID: logitech-hidpp: add USB PID for a few more supported mice")'
> 
> This caused some issues and was reverted by
> 'addf3382c47c ("Revert "HID: logitech-hidpp: add USB PID for a few more
> supported mice"")'.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.5/upstream-fixes), thanks!

[1/1] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
      https://git.kernel.org/hid/hid/c/a343a7682acc

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

