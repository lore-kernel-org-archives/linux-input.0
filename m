Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBCFC433E0
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149042145D
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321231;
	bh=9j4HI6ctibytNGtvPasf+aTPcPn0YsERuuz5XxUwj+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=eQDsngv1q8nNKiNlqYHMd2q66VqKLPVZpSF0/NcRHnHZYrn8dT2cjJMqR+AnaFYzJ
	 Scdw64BgHZk7/091QMTohEpVhNy0XHlBlnM1Zzb/G5cKhOUmDCvJAKDD4c6MozJ17b
	 GnaarR4eI+lHL+us3eYophP730e+jyWUZZqZpwL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFPP1K (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgFPP1K (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 11:27:10 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18C8208B3;
        Tue, 16 Jun 2020 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321229;
        bh=9j4HI6ctibytNGtvPasf+aTPcPn0YsERuuz5XxUwj+E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pkwYFzvksQlS105hCPAM8h65j95gaX01EH2RzPTLPfrR5IPqbKmtA6DLd2w6CS/au
         c8qJOfWqltsZTzNZrtbG6EuIw/g01n9aXeVBJWPPm5RY6tjNC84BWE5OKjmgGK2LES
         M8awKb4Hc1eRdR6SQzX4H6rL6yfRdCK6NKqGkGzI=
Date:   Tue, 16 Jun 2020 17:27:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Parschauer <s.parschauer@gmx.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Always poll Obins Anne Pro 2 keyboard
In-Reply-To: <20200609100053.15016-1-s.parschauer@gmx.de>
Message-ID: <nycvar.YFH.7.76.2006161726550.13242@cbobk.fhfr.pm>
References: <20200609100053.15016-1-s.parschauer@gmx.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 9 Jun 2020, Sebastian Parschauer wrote:

> The Obins Anne Pro 2 keyboard (04d9:a293) disconnects after a few
> minutes of inactivity when using it wired and typing does not result
> in any input events any more. This is a common firmware flaw. So add
> the ALWAYS_POLL quirk for this device.

Applied, thanks Sebastian.

-- 
Jiri Kosina
SUSE Labs

