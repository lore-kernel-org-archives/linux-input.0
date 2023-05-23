Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6CDC77B75
	for <linux-input@archiver.kernel.org>; Tue, 23 May 2023 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjEWNMZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 23 May 2023 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbjEWNMN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2023 09:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFCA109;
        Tue, 23 May 2023 06:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC2760B2C;
        Tue, 23 May 2023 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E37BC433EF;
        Tue, 23 May 2023 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847530;
        bh=nVNVKCroG2DRvFC/0imQI8MOw3h1mDhbsG3ornLiA1k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GDQ+ipEmwgAM4KkwIlbeNpcF11aXBoZgQo5Utfi0u4R24Ktdk9PI/2nImGwpKMJgy
         TY2Kq121LeNckPgZI3+jbXp/hFaqN6AuNnsW/NAl4TB0SkIgCGkFKpbsDOLjloo8yC
         0wqQtjGGuH48mrKOuIxWHPK5z/z3JZTjrLN/vP1v+b8vBc2EYyMz14MHooItn26O8w
         J6KnepEi7B0V8qO2MFl+4gSoluxgckryEyj8g52nDWGC25vLy5O+u9VN+Ssf+h3sRz
         oEBs6GGZvNEJeSaya5NjS1EWJbN4CQ48t5Z5c3N0P0p4WjS+6V+dZTGosGvFe7QVam
         DdaBNVOtxuOqw==
Date:   Tue, 23 May 2023 15:12:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Arefev <arefev@swemel.ru>
cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] HID: wacom: Added error check
In-Reply-To: <20230427114745.53136-1-arefev@swemel.ru>
Message-ID: <nycvar.YFH.7.76.2305231511590.29760@cbobk.fhfr.pm>
References: <20230427114745.53136-1-arefev@swemel.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 27 Apr 2023, Denis Arefev wrote:

>    Added a variable check and
>    transition in case of an error
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

