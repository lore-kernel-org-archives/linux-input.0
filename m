Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F0C433EF
	for <linux-input@archiver.kernel.org>; Tue, 31 May 2022 08:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiEaIy1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 31 May 2022 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEaIy0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 May 2022 04:54:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D08FFB5
        for <linux-input@vger.kernel.org>; Tue, 31 May 2022 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGow7MgUBq/l0vPG8dNroaog9E3YynIEC2soOLsJJNU=; b=KQgr24xk7xl1+J3U69w7IvEpQm
        IO3pryeiiYGzpsV9MKjuHl5f/iXmUJ4MZ4wTqXQ2RW80xkk+suy3rqMQNPCYmvYspZEB9tHsrOvss
        TgVyu+4W/E6kexjYhGPpzBkEfU9fXewdrJfmp/L5/1Y98w97VNq4kUfa3660AO53h3fQFecPPRoeg
        V8PYiNZ5eAAOALG5uC/u5oICkP7roofH69dlpXaZwnRpAQSNPWdTx5liKK435FScp6YLgKq93WMns
        EnJUC8R4viRupei4OqUCiEp475321rn2ykcB/U/NJywdXUcDu/905DCyrw1dZXRaMA7xp6BYOjvkm
        75oejttA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvxdt-005C2y-L4; Tue, 31 May 2022 08:54:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00A38980DCA; Tue, 31 May 2022 10:54:19 +0200 (CEST)
Date:   Tue, 31 May 2022 10:54:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org
Subject: Re: Suspend/Resume (S3) issues with rmi_smbus
Message-ID: <YpXXu2tbCSCUtUYQ@worktop.programming.kicks-ass.net>
References: <YpSExunpPdgdjQCz@worktop.programming.kicks-ass.net>
 <YpUX3EAzpL4+xgu1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpUX3EAzpL4+xgu1@google.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, May 30, 2022 at 12:15:40PM -0700, Dmitry Torokhov wrote:

> Can you check the entire list of resume operations to make sure that
> PS/2 device is resumed before RMI one?

It reports psmouse failure *after* the rmi4 failure. Is there a knob to
make it print more device model details on resume?

> You can also try overriding devices driven by rmi_smbus as needing
> synchronous resume (see
> https://lore.kernel.org/all/YgHTYrODoo2ou49J@google.com/).

I can confirm this works.
