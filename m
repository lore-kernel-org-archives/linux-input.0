Return-Path: <SRS0=p1C8=X2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD75ECE587
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C2D2086A
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569939401;
	bh=J9ed0KJmRZLdI0okBxc82Ypt6X45ISUClcmfQyIa8eQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=L1NUNvNnOvJ7Cc1NqSFOMgiYBdD+Cpqv5wwjY+wzb6OQqV1XKcBdzLtdIj1oRqVsO
	 //NH3Ra6RkxL37ID0uPCrs+6h4XFoEA+n12mDGTHQptv7Eeabx5wm0Q+73o76YUZtS
	 Jl/Fdm/iPKVU+qrs7jlhp6VT6RfHhlD5Uf1XaqNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfJAOQk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388825AbfJAOQk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Oct 2019 10:16:40 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5CF2086A;
        Tue,  1 Oct 2019 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569939400;
        bh=J9ed0KJmRZLdI0okBxc82Ypt6X45ISUClcmfQyIa8eQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=td/yed3D8cE+/wFon8OrIygIUcF1RdDoL0ZCxVhvd3nTK7sAHcfZ+nmGAeH7n6W5+
         Y4Pj26R3fXm7CXOBP9W5QSSDCAtaR3SJMLl/JhqN48E+T4eD1f7lSpcIMU8znWa+1u
         FYEAI3nzLnzccVQzf5fhvYSambBaaKPrcV3RrUug=
Date:   Tue, 1 Oct 2019 16:16:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dtor@chromium.org>
cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] HID: google: whiskers: more robust tablet mode
 detection
In-Reply-To: <nycvar.YFH.7.76.1909231108330.1459@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1910011616020.13160@cbobk.fhfr.pm>
References: <20190913220317.58289-1-dtor@chromium.org> <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com> <CAE_wzQ9U-Lu=Uce0jFjec9JMYMhsQZoTuB+xqDpkOdC+Ufq6Ng@mail.gmail.com> <nycvar.YFH.7.76.1909231108330.1459@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191001141613.3UaAIB-pqT_E-ROU-y-fhTBqZAuQnhkMcePnPIfnw74@z>

On Mon, 23 Sep 2019, Jiri Kosina wrote:

> > > > The USB interface may get detected before the platform/EC one, so let's
> > > > note the state of the base (if we receive event) and use it to correctly
> > > > initialize the tablet mode switch state.
> > > >
> > > > Also let's start the HID interface immediately when probing, this will
> > > > ensure that we correctly process "base folded" events that may be sent
> > > > as we initialize the base. Note that this requires us to add a release()
> > >
> > > s/release/remove/ ?
> > 
> > You are right.
> 
> I'll fix that up when I am applying it (once 5.4 merge window is over).

Now applied (with the fixup made). Thanks,

-- 
Jiri Kosina
SUSE Labs

