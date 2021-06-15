Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2EC48BDF
	for <linux-input@archiver.kernel.org>; Tue, 15 Jun 2021 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF84611C0
	for <linux-input@archiver.kernel.org>; Tue, 15 Jun 2021 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFOIuV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Jun 2021 04:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFOIuU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Jun 2021 04:50:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E1B613D9;
        Tue, 15 Jun 2021 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623746896;
        bh=rq8b8IQD7QoDe/yzysJJ+zlbqLGNiTGLxDQqhUTiOiA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=X3SJZGJaLXE8cRbAM2j16lGhWQPrmfR47xKFyyYGkf9rf1AzDA2xamFa1e8V7VPbO
         Q5o32v1AZBME1l+6Jsx5fKT2Ft4Uq5tOYeVAUszT54TmSiMcMThM0WTigErs7PbhYz
         RRT5mT6CqI2XggShDSkZswkvvChyTzWG02UVj/hrDRc5JTdwAxKTHQP3qZUJFaI9dO
         UBRPqIU8vEKhe9w5valNH83oh+ZJOt8Qxy55GU90E6ieRWCzw8GeGIocYykwmYiTci
         MdQbXDznFbxroZsdIsCQukndTnXpnkzex7NsMfWIlCvtfcSS14tns6T6Rze0D0pr4Z
         WfEKe1I9TGEpw==
Date:   Tue, 15 Jun 2021 10:48:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: input: Add support for Programmable Buttons
In-Reply-To: <20210520084805.685486-1-linux@weissschuh.net>
Message-ID: <nycvar.YFH.7.76.2106151047190.18969@cbobk.fhfr.pm>
References: <20210520084805.685486-1-linux@weissschuh.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 20 May 2021, Thomas Weißschuh wrote:

> Map them to KEY_MACRO# event codes.
> 
> These buttons are defined by HID as follows: "The user defines the 
> function of these buttons to control software applications or GUI 
> objects."
> 
> This matches the semantics of the KEY_MACRO# input event codes that 
> Linux supports.

I have only a very small nit, otherwise I am fine taking the patch for the 
upcoming merge window -- could you please also briefly mention in the 
changelog the fact that you are adding support for a new collection type?

Thanks,

-- 
Jiri Kosina
SUSE Labs

