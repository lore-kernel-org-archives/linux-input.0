Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F1C7EE2C
	for <linux-input@archiver.kernel.org>; Fri, 25 Aug 2023 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHYJo1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Aug 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjHYJoX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2023 05:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403F19A1;
        Fri, 25 Aug 2023 02:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68F3360D3D;
        Fri, 25 Aug 2023 09:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375CAC433C8;
        Fri, 25 Aug 2023 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692956659;
        bh=me1uoWKkEzgLUsTWeqOu/DWILOAbSgEJUKQu/4VvDZw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dH2yzUTTY2b7oQyz+3nAkP0NdHuO5NqCTKuIyrMg/wfm97eKhPl6/siE2zzCkOnOG
         yDfHIqWBruqfsIhG2Wwy7FjalnyqTz0IdavmkM8I2dugiG+6B32m7IHzuZySerCt7d
         yNUYQT0H8MPJb4rpEYS1u5dLVs9YPuUaXaAjS1UnG/7RuAMe+i+4KXN0aUeRy7lWbO
         +SdRy1FfN+e5s8D3AuJRmQpFdEBc0YZzOif5QLCSARhZqaJpugoq3xd358ef3C8fS2
         u87UmbBvQ6K3vTH+vE9Hw5gdn1sCsdrvF9V9ahZjoA9vtdBlCiA+RWaVNupUymfww7
         FUwnH/OOTIqqw==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, bentiss@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
In-Reply-To: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org>
References: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org>
Subject: Re: [PATCH v2] HID: logitech-hidpp: rework one more time the
 retries attempts
Message-Id: <169295665797.600550.12347431863419633471.b4-ty@kernel.org>
Date:   Fri, 25 Aug 2023 11:44:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 12 Jul 2023 17:02:34 +0200, bentiss@kernel.org wrote:
> Extract the internal code inside a helper function, fix the
> initialization of the parameters used in the helper function
> (`hidpp->answer_available` was not reset and `*response` wasn't either),
> and use a `do {...} while();` loop.
> 
> 

Applied to hid/hid.git (for-6.6/logitech), thanks!

[1/1] HID: logitech-hidpp: rework one more time the retries attempts
      https://git.kernel.org/hid/hid/c/60165ab774cb

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

