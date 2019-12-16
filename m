Return-Path: <SRS0=KWuL=2G=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E0CC43603
	for <linux-input@archiver.kernel.org>; Mon, 16 Dec 2019 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F286D20665
	for <linux-input@archiver.kernel.org>; Mon, 16 Dec 2019 18:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kryma.net header.i=@kryma.net header.b="MJiBr+nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLPSw7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:52:59 -0500
Received: from li825-139.members.linode.com ([104.237.157.139]:50458 "EHLO
        smtp.factglobal.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbfLPSw7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Dec 2019 13:52:59 -0500
Received: from [192.168.42.166] (unknown [216.154.3.143])
        by smtp.factglobal.ca (Postfix) with ESMTPSA id 9D41178AFA
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2019 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kryma.net; s=mail;
        t=1576522378; bh=fjBXksq/lfPZHk5znGhRAtp7ypAmbYZrfsnAYJcRd7U=;
        h=To:From:Subject:Date:From;
        b=MJiBr+nqI7AXl3HFLfSHR4/MHohiNN0um00RzCaccqsc6MelEFwTDFUiGNtPMHk4r
         bJtWDmRg38QetjsyVlzu5VebItc+4xfCSgTH6TiJO/EO4B3xmV5zzUH9XLYpWYnFz2
         YrFVq/DlQO64eAvh+KoQ4ytQ6ZBQBjGPETby+WII=
To:     linux-input@vger.kernel.org
From:   Pavel Balan <admin@kryma.net>
Subject: Interface design advice
Message-ID: <6add23bb-db95-52d5-03d4-e1da2325e2f5@kryma.net>
Date:   Mon, 16 Dec 2019 13:52:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

I'm currently porting a HID backlight peripheral to Linux.

The backlight has 4 sectors, each can have two independently set 
parameters - style and colour. What would be a good way to give the user 
access to this interface, without it being either obtuse or overdesigned?

