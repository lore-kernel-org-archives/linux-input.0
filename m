Return-Path: <SRS0=X7PX=EE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D3C55179
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02ED020838
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603984518;
	bh=MSgEfMISpSMcIDN6JU/HuYIsD2RxZtDhm0gqWsBs1tc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=pYH7jEPxRr9LUdkZ9FcaFMzdMImSs8+UK4T8out5nvBfoZp0i220yT7l/NmYZpszd
	 de/S7CzNEjt99V61+HFhe6oWcdK460wR6ZnJFV2ddPgWLFVqyRA+Lz7qrMdtZqBGrm
	 PLkrl4y34bOY9Ep6xJG7ECCY16Z7qP3yBBCr2kxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgJ2PPR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgJ2PPR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Oct 2020 11:15:17 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6622076E;
        Thu, 29 Oct 2020 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603984516;
        bh=MSgEfMISpSMcIDN6JU/HuYIsD2RxZtDhm0gqWsBs1tc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=r6AdDOhLDppfX/bbyJkS0quOfymLiV8GAfHRiMVz/RumoS4GTw/vb6/Iy9r5aQodc
         nFegZBiySuVe0y4mQJlx/k2H7byDSfGrr5TQHZnT3h/q4+/F5VI0ee5ZHdfl0HYYgd
         Mcvn0n4a9R1amZTZ/4OQf5iZvyZXgqxtemNhVsuU=
Date:   Thu, 29 Oct 2020 16:15:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Kenneth Albanowski <kenalba@google.com>,
        Sebastian Reichel <sre@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Johan Korsnes <jkorsnes@cisco.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: hid-input: occasionally report stylus battery even
 if not changed
In-Reply-To: <20201027173820.GK444962@dtor-ws>
Message-ID: <nycvar.YFH.7.76.2010291614540.18859@cbobk.fhfr.pm>
References: <20200930224713.GA88246@dtor-ws> <CALvoSf7kZEhrZZEZmzpAkEMbd+TQbNTCOmjvjX6RfxeWiQZz2g@mail.gmail.com> <20201027173820.GK444962@dtor-ws>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 27 Oct 2020, Dmitry Torokhov wrote:

> M
> On Wed, Oct 07, 2020 at 03:05:13PM -0700, Kenneth Albanowski wrote:
> > I've tested this locally backported to a 4.19 variant; it does work,
> > and provides the expected additional CHANGE events while safely
> > limiting the rate.
> > 
> > This seems like a reasonable minimum improvement, just ensuring
> > information already being pushed by HID reports can be utilized.
> > 
> > I'm unsure about mapping Digitizers.InRange to power_supply 'present',
> > in the abstract. It seems there could be a device where
> > Digitizers.BatteryStrength is sent, despite Digitizers.InRange=0, and
> > the HID Usage Tables don't quite seem to rule this out (depending on
> > how battery status collection interacts with 'the region where
> > digitizing is possible', section 16.3.1.).
> > 
> > As-is, this is useful and sufficient to get more timely reports up to userspace.
> 
> Jiri, if there are no better ideas, maybe this one can be applied?

Agreed (I certainly don't have better one :) ). Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

