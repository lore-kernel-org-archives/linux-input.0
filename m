Return-Path: <SRS0=NdRw=DG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB6DC4727C
	for <linux-input@archiver.kernel.org>; Tue, 29 Sep 2020 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D22F207C4
	for <linux-input@archiver.kernel.org>; Tue, 29 Sep 2020 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601387137;
	bh=9pn0/W2fI84mXs5twStisDhG3sJRj7czmlR6ANniw4E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RktR/C1ya/2OT5XPTSB181DD2IkDVqFXu30dHSsCt0CAHY4UXjHH/B0deCAxd/5Ci
	 QsWWYln33xT4umAhpKbVS0Rg3h67mH/fPMmmq1xY04RGMRbGy1qIhd+jM3OBIs8PpM
	 sKU7cYYeqEAV6G7/fmVtCFDG0i8FlJod08z2Tjck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgI2Npg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 29 Sep 2020 09:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgI2Npg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Sep 2020 09:45:36 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3202075E;
        Tue, 29 Sep 2020 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387136;
        bh=9pn0/W2fI84mXs5twStisDhG3sJRj7czmlR6ANniw4E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=wnLQDEDthjF5wcoszbEPNaw0jzFqknSwMY8sQ7OmWL7ExkhqyNdYMzc8QSbg8+uMD
         Ya/+6hQ72RgfGVevI4Fg6UYtAB45PA8tAcQ2rrsoR8tPJ4Pvm5t4g5akWq8Zjx0qTv
         Y4788p/zPyNDoVtJ0cWb6Hd/FaAu3mApoSoPhkok=
Date:   Tue, 29 Sep 2020 15:45:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Benjamin Tissoires <btissoir@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Chris Heiny <chris.heiny@synaptics.com>
Subject: Re: [PATCH 0/3] Add support for F3A
In-Reply-To: <05140fb1-19a5-d740-2c57-e39e450142ec@redhat.com>
Message-ID: <nycvar.YFH.7.76.2009291544580.3336@cbobk.fhfr.pm>
References: <20200924094628.1085000-1-vincent.huang@tw.synaptics.com> <05140fb1-19a5-d740-2c57-e39e450142ec@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 27 Sep 2020, Hans de Goede wrote:

> Otherwise the patches look good to me and I can confirm that
> they fix clickpad clicks not registering when using rmi4 for the touchpad
> on the Lenovo T14 gen 1.
> 
> So for version 2 (with patches 1 and 2 combined into a single patch)
> you may add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

For the folded version

	Acked-by: Jiri Kosina <jkosina@suse.cz>

I believe this is better merged through Dmitry's tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs

