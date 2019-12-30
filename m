Return-Path: <SRS0=RQR1=2U=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD2EC2D0C3
	for <linux-input@archiver.kernel.org>; Mon, 30 Dec 2019 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1358320658
	for <linux-input@archiver.kernel.org>; Mon, 30 Dec 2019 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kryma.net header.i=@kryma.net header.b="Yg17lJOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfL3W2w (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 30 Dec 2019 17:28:52 -0500
Received: from li825-139.members.linode.com ([104.237.157.139]:44292 "EHLO
        mail.factglobal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3W2w (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Dec 2019 17:28:52 -0500
Received: from [192.168.0.187] (modemcable184.72-21-96.mc.videotron.ca [96.21.72.184])
        by mail.factglobal.ca (Postfix) with ESMTPSA id 60A5D78B16;
        Mon, 30 Dec 2019 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kryma.net; s=mail;
        t=1577744931; bh=uZWINKqbHxlYQEYMzbrs714nFkwiIgVBy6DAVX23wXQ=;
        h=To:Cc:From:Subject:Date:From;
        b=Yg17lJORm7gnswbK3wnwB4Kw/uP8RjndK0IaPFbxF5oCNky5zHTW+i8HeGJCu2ohD
         xpXNK2SBlHdA7Kp8XkOtw3mYmX/EdsgW3uhRNX3gFl9DQBAsyvpZV0qiN71k6gSy8I
         7yBoThVQ0eHi8lLpjos3jPsiE1UuJkMifwUrmzPs=
To:     jikos@kernel.org
Cc:     linux-input@vger.kernel.org
From:   Pavel Balan <admin@kryma.net>
Subject: Hotkey activation of a HID function
Message-ID: <a6de4f52-414e-2ffb-26f9-5b7211c55a91@kryma.net>
Date:   Mon, 30 Dec 2019 17:28:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Good day Jiri,

I am currently in the process of writing a driver for a laptop backlight 
peripheral. It takes a HID feature request to activate - and according 
to the way it works in Windows (thanks to pre-installed software 
packages), the driver activates it on receiving a hot-key combination.

Is there a paved, proper way to implement that functionality - provided 
the built-in keyboard and the backlight are two separate devices?

Thanks in advance, and happy New Year.

