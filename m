Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C81BC433EF
	for <linux-input@archiver.kernel.org>; Fri,  6 May 2022 06:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbiEFGfA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 May 2022 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiEFGe5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2022 02:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE485DA63;
        Thu,  5 May 2022 23:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36252B83341;
        Fri,  6 May 2022 06:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA8C385A8;
        Fri,  6 May 2022 06:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651818671;
        bh=y7POrv73PpQHvD+HJqu0OGbIrN/X8i4wShhzutDoNX0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OzcstYxVxRaqjttZMVdNB/j1mObbqE26OxUEAA2qJZYcM2u4QbvmEcghtJeyGINiO
         gPh2qi+Socw1tNeBI98qtmTGTTr7CBIY9L+jU+tBKTQfih5c4VI18EhORwB23fKv7r
         tpnE+Pw1YCUPE/9OeW0mu66c6lO7O4vTw4AOMxjjyV+1CcBMw7i2AeOx6/mrpKi6Nl
         8jFeaG0SWoFcIy791OM5hPgWgH5dWq6I+556eYoZTSaGr4914uMxOhSKjCjusk7mUJ
         lCNv7NU72CSQTdL9frxahIbu6VkuowbHbkd1Vs5j6zughZPVRjpZCEdI7Ys354oibo
         KIu0Y3EWfH+fw==
Date:   Fri, 6 May 2022 08:31:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     frank zago <frank@zago.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: Add support for Mega World controller force
 feedback
In-Reply-To: <20220421024041.98786-1-frank@zago.net>
Message-ID: <nycvar.YFH.7.76.2205060830550.28985@cbobk.fhfr.pm>
References: <20220421024041.98786-1-frank@zago.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 20 Apr 2022, frank zago wrote:

> This patch adds support for one of the several Mega World USB game
> controller with integrated force feedback. It is a HID based
> memory-less game controller, with a weak motor on the left, and a
> strong one on the right.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

