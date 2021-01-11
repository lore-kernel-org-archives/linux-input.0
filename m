Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B442C433DB
	for <linux-input@archiver.kernel.org>; Mon, 11 Jan 2021 00:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C0C22AAC
	for <linux-input@archiver.kernel.org>; Mon, 11 Jan 2021 00:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAKAGM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:06:12 -0500
Received: from rtinjuhl.dk ([80.210.71.103]:53040 "EHLO jarjar.outerrim.lan"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbhAKAGM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 10 Jan 2021 19:06:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by jarjar.outerrim.lan (Postfix) with ESMTP id E84F9300941
        for <linux-input@vger.kernel.org>; Mon, 11 Jan 2021 01:05:25 +0100 (CET)
Received: from jarjar.outerrim.lan ([127.0.0.1])
        by localhost (jarjar.outerrim.lan [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sX_1laacWsVo for <linux-input@vger.kernel.org>;
        Mon, 11 Jan 2021 01:05:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by jarjar.outerrim.lan (Postfix) with ESMTP id A6735300980
        for <linux-input@vger.kernel.org>; Mon, 11 Jan 2021 01:05:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 jarjar.outerrim.lan A6735300980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtinjuhl.dk;
        s=2ECB6950-47A0-11EA-A1BF-D0BE459925E1; t=1610323525;
        bh=Xfd363igFvFWIl1GE2VCtrAk2mxJjMDrY0oTioWcpRM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=M3WTsnQV41xFbruIcaiKxcwBHhlOD+S1k3Vp/SCHSwfP8S8EZEiIrXaUILw1gIy7L
         lFlJZYOGbyTN9XjqnV5ogi+0C9qOikO1ul8EdE10qMmOT3TAFQ6ySPOmwGM0oPvmWm
         31kU/fBR/Lr05AA97fv2CtdjyHCeEvufCt55FiAPcmMb3zt4i2CaSUU9wnVxEVYIu4
         FGLCBV0JcVX4flAPhUq+lkolLZ9DYEsxLC3jCIhrYUks3GkEvDsjMw/W0jR6gLh6Lk
         GXGLpSVaHPDZ7tGMmC2mEVc8VyRAmeJK+ZogJ3ITi0t3uYnmJoUk5WwYEn0Hr7BjnB
         PAVOHKYrJNZ6g==
X-Virus-Scanned: amavisd-new at mrmeee.dk
Received: from jarjar.outerrim.lan ([127.0.0.1])
        by localhost (jarjar.outerrim.lan [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 99RIlq3DpuuX for <linux-input@vger.kernel.org>;
        Mon, 11 Jan 2021 01:05:25 +0100 (CET)
Received: from jarjar.outerrim.lan (jarjar.outerrim.lan [192.168.60.115])
        by jarjar.outerrim.lan (Postfix) with ESMTP id 93D99300941
        for <linux-input@vger.kernel.org>; Mon, 11 Jan 2021 01:05:25 +0100 (CET)
Date:   Mon, 11 Jan 2021 01:05:25 +0100 (CET)
From:   Martin Juhl <m@rtinjuhl.dk>
To:     linux-input@vger.kernel.org
Message-ID: <53373429.523024.1610323525561.JavaMail.zimbra@rtinjuhl.dk>
Subject: Stabel ids on Identical devices on the event input subsyste
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.60.115]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF84 (Win)/8.8.5_GA_2000)
Thread-Index: +twJgE5hI8PWVXrUgLJp2WWJUvxluA==
Thread-Topic: Stabel ids on Identical devices on the event input subsyste
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi guys 

If I have several identical joystick connected, with the old /dev/input/js* system, they would appear in the same order (if they were initialized in the same order).. but on the event system, they most times are not.. (probably because other event devices are initialized in between).. 

Is there anyway to solve this?? 

Regards 

Martin
