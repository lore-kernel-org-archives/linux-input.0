Return-Path: <SRS0=p1C8=X2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C4C352AA
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B2B21855
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569939618;
	bh=UBnUQs50xSOkAzYN97eAZdHXL9k0XEWd0kn+PTRxajU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=i+PudL1xuSfYtMfgseUNdLTrcgT2Au4riuNF7y0/wmRN+2MegD+4O6lmXQ5KN8oGD
	 sJj1oBJT21JqBp48RtgXKERmE0hGuMoCWixRGIjmiax1yWd1Q9oj3AQjO07DJafZpr
	 a+ywlu28vgqFkZN1ZTYW9OIqYGOnFvXsqFkESo1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbfJAOUS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfJAOUR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Oct 2019 10:20:17 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2332086A;
        Tue,  1 Oct 2019 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569939617;
        bh=UBnUQs50xSOkAzYN97eAZdHXL9k0XEWd0kn+PTRxajU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=prT1Fl0YizlgUboDPPxpvbZVV3SIGE00+dMlBtgmbgqP2s4Y36KEsx6rGTtadGOQy
         wKEwLgLclodCRs1bQzLK2lTFrNTfTrz8axTBqpJujYH8suF7TejEbyvBtq6fAdqGJJ
         5rgpw0aRNPnRhd4yp/6vJ7feBYTNdsFNcX1x2N+Q=
Date:   Tue, 1 Oct 2019 16:19:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: fix error message in hid_open_report()
In-Reply-To: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
Message-ID: <nycvar.YFH.7.76.1910011619280.13160@cbobk.fhfr.pm>
References: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191001141950.WwzWlLeFtPmE5CQ3A9k2LtDQ-tw6cydzXmElIw6xFis@z>

On Fri, 23 Aug 2019, Michał Mirosław wrote:

> On HID report descriptor parsing error the code displays bogus
> pointer instead of error offset (subtracts start=NULL from end).
> Make the message more useful by displaying correct error offset
> and include total buffer size for reference.
> 
> This was carried over from ancient times - "Fixed" commit just
> promoted the message from DEBUG to ERROR.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> ---
> v2: fixed printf() warning spotted by Jiri Kosina <jikos@kernel.org>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

