Return-Path: <SRS0=UBMJ=XZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D544C4360C
	for <linux-input@archiver.kernel.org>; Mon, 30 Sep 2019 06:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DB3207FA
	for <linux-input@archiver.kernel.org>; Mon, 30 Sep 2019 06:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="YhwjT/za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfI3GZ7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:25:59 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:35523 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729522AbfI3GZ7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Sep 2019 02:25:59 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 02:25:58 EDT
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 253D14200EA1
        for <linux-input@vger.kernel.org>; Mon, 30 Sep 2019 09:20:11 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id B2zKtRu0IB-KAseqOcK;
        Mon, 30 Sep 2019 09:20:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail; t=1569824410;
        bh=dkkstuilaL1m+x1piuT7mHTMqUyLTl5dm+BTH75P7dA=;
        h=Message-Id:Date:Subject:To:From;
        b=YhwjT/za/0AjR7wjZz8ukdFMWhCVUgrLHgOKO0JJ215QM2j6wL6c5IP76K7dGS7Bs
         O0+o7td971Xtc4i59WwvJci8vlvcZmoF8S9h6Nd2QeAN5WYaemI16b44Pz3TYyr/9U
         oxVjJuLhZjnSvs6rWwvog9lEPRqN36PSvCNzEwNA=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@0upti.me
Received: by iva1-adac53ff5c48.qloud-c.yandex.net with HTTP;
        Mon, 30 Sep 2019 09:20:10 +0300
From:   Ilya K <me@0upti.me>
To:     linux-input@vger.kernel.org
Subject: Your touchpad (PNP: LEN0099 PNP0f13) says it can support a different bus
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 30 Sep 2019 09:20:10 +0300
Message-Id: <8671951569824410@iva1-adac53ff5c48.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi everyone! 

I've noticed this message on my Lenovo ThinkPad X1 Extreme, and verified that the touchpad works with InterTouch enabled. I'd be happy to submit a patch to enable it by default - it looks like the device ID just needs to be added here: https://github.com/torvalds/linux/blob/97f9a3c4eee55b0178b518ae7114a6a53372913d/drivers/input/mouse/synaptics.c#L128 ? 

Thanks!

P.S. please CC me on responses, as I'm not subscribed to the list
