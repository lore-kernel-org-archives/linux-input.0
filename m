Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5F0C7EE23
	for <linux-input@archiver.kernel.org>; Mon,  5 Jun 2023 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFEUDg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFEUDg (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2023 16:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A198;
        Mon,  5 Jun 2023 13:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4748962A36;
        Mon,  5 Jun 2023 20:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B7C433EF;
        Mon,  5 Jun 2023 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685995414;
        bh=WJhJS6jTOVxBpVhHBmqByAVw0RYngt62X3Zy0ClDkQM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gKLfmAcBFdHcovw75B1DnpghjHujR36Sp7oR52D63yGXR/98BctoRseUEhDyOastW
         k+fQjWsPRn30dCIhQv/HIKMFhA7bz+lj5fGLjAHu7uph/VVaRLsOhJcyRA2MASDS1e
         OqCvAOCuQy2a6HZQgKMhg7aKouH5V3wBfw/fxuHP1WMv9zPayoIcoiXNLMjwxgSQGa
         hIn7ZY4daOauAj/gF+vRk4RxyvEtqKz7caYGBeI1wAxbZPlawEJfwqiUN43qcBuiQp
         DSIc3D6OSfw5VfOW7ST4UR+DQqs8BX5HAJxozIKKnoPJQ2LvT2t7CwVA8Vo+gvvUdB
         zWgHOwJs3Dijg==
Date:   Mon, 5 Jun 2023 22:03:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mark Lord <mlord@pobox.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from
 busy
In-Reply-To: <8c65b3a0-6040-52e7-7e6d-1a18cbe7a22e@pobox.com>
Message-ID: <nycvar.YFH.7.76.2306052201260.29760@cbobk.fhfr.pm>
References: <20230531082428.21763-1-hadess@hadess.net> <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm> <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm> <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info> <7ko33em3pqdaeghkt6wumzks6fz2lzztmqyhyzvv3kisjovmvr@mojlmkmrqlml>
 <2c10eb8f-8804-d47f-7b15-5da56ffb5414@pobox.com> <ansxam7w4aiyyqh4e2g2elnd37qfbeywkl4q4rcezasw64kqc4@2c54ppsnhegm> <8c65b3a0-6040-52e7-7e6d-1a18cbe7a22e@pobox.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 5 Jun 2023, Mark Lord wrote:

> Tested-by: Mark Lord <mlord@pobox.com>
> 
> That works fine for me on top of 6.3.6, and I don't even see the 
> ETIMEDOUT happening there either (added a printk() for it).
> 
> I am unable to test on 6.4.0-rc5, because that kernel doesn't work with 
> my USB3 docking station.

Thanks a lot, Mark!

Applied and will be sending to Linus soon.

-- 
Jiri Kosina
SUSE Labs

