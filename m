Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A493AC0015E
	for <linux-input@archiver.kernel.org>; Mon, 10 Jul 2023 08:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGJIdV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 10 Jul 2023 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjGJIdC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2023 04:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070ACE73;
        Mon, 10 Jul 2023 01:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9539B60F03;
        Mon, 10 Jul 2023 08:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7758C433C9;
        Mon, 10 Jul 2023 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688977969;
        bh=RBD+9rZAJ9DiIem6iOrErjZL38XJTPgIwJHH7LduCss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HeG/4HJCjd9J1/6VeHPlMfIMw5Sisn/HqTMNksjz8J1K8L/1teh9VkrAkLxVnMvlu
         PYD2H8zaoblWHSshXYb//bvjUF1JQwENwkybvu0r1ZiQXWepeoBkqV4jDmSwwiETWU
         55nPdSFJiffaYBgxSObVyVdBDjJny/0EWA+XNNT5bWgHaoLADkXSLIYgReFZBNyD1e
         tVL6Fqu1uFhDJj+I4sdumRbSLjXFmom8E8hqWi8vjpC3VPkousCJOiIn+3AKtYOZgY
         hnhRbxw8I9Cqk4tYbyiMVjKGgDqviGq1WMruV3PDORM+O3ZZc3+LSBNwVgvUBr1GDr
         Gvfdz8g58aF8g==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?utf-8?q?Eray_Or=C3=A7unus?= <erayorcunus@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZJtd/fMXRUgq20TW@google.com>
References: <ZJtd/fMXRUgq20TW@google.com>
Subject: Re: [PATCH] HID: input: fix mapping for camera access keys
Message-Id: <168897796761.315593.173904580565691367.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 10:32:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 27 Jun 2023 15:09:01 -0700, Dmitry Torokhov wrote:
> Commit 9f4211bf7f81 ("HID: add mapping for camera access keys") added
> mapping for the camera access keys, but unfortunately used wrong usage
> codes for them. HUTRR72[1] specifies that camera access controls use 0x76,
> 0x077 and 0x78 usages in the consumer control page. Previously mapped 0xd5,
> 0xd6 and 0xd7 usages are actually defined in HUTRR64[2] as game recording
> controls.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.5/upstream-fixes), thanks!

[1/1] HID: input: fix mapping for camera access keys
      https://git.kernel.org/hid/hid/c/e3ea6467f623

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

