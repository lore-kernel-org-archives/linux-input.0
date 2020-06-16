Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA9AC433E0
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42FF208B3
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592320754;
	bh=cR/WVUdzgqdDcyz4huGoobchsFZLWP6Q2tS1mzbNvwE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RdXtFupOR9H//c7Vo2TDKl+DEz/vv+9NmHtKTw/zM8O/WeAgYPU5B8AnfUiTsAIpR
	 uR9RcymhSHLReVFMfjkNT80tHufA7iG6+0jQ20Opr7T6HFjKWRKa37l+tKI9FfB9lN
	 G99v47FJpvH1m5MmbB4ZvSp2PgeoIw6E/jkuLFyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgFPPTN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgFPPTM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 11:19:12 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A7A5207C3;
        Tue, 16 Jun 2020 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592320751;
        bh=cR/WVUdzgqdDcyz4huGoobchsFZLWP6Q2tS1mzbNvwE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=l/jZhiyZS5oMkzphSflTaqL4/JlPkWB9uB/SAi5scwIo3CEdv5/Pq751g/kU5sjSK
         SPmWAvwlDhhqxGIrspHNf5faLhytt8dBfcoDeTpCEl+cknOx36gCYhWB6A2+elRstr
         DBwTMu5E5OV76n4jne+n+QXeLvrhxuej8vf+HrVE=
Date:   Tue, 16 Jun 2020 17:19:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Federico Ricchiuto <fed.ricchiuto@gmail.com>, jikos@kernal.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor
 override
In-Reply-To: <197d680d-a38b-b478-1b7a-9c821ada0846@redhat.com>
Message-ID: <nycvar.YFH.7.76.2006161718550.13242@cbobk.fhfr.pm>
References: <20200615204914.15549-1-fed.ricchiuto@gmail.com> <197d680d-a38b-b478-1b7a-9c821ada0846@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 16 Jun 2020, Hans de Goede wrote:

> Hi,
> 
> On 6/15/20 10:49 PM, Federico Ricchiuto wrote:
> > The Mediacom FlexBook edge13 uses the SIPODEV SP1064 touchpad, which does
> > not supply descriptors, so it has to be added to the override list.
> > 
> > Signed-off-by: Federico Ricchiuto <fed.ricchiuto@gmail.com>
> 
> It looks like you copied and pasted part of the commit message from
> another patch (which is fine), but you need to update the Subject
> (the first line of the commit message) the Subject now still
> mentions the Trekstor Surfbook E11B rather then the
> Mediacom FlexBook edge13.
> 
> Otherwise this looks good to me.

Thanks. I've fixed up the subject and applied.

-- 
Jiri Kosina
SUSE Labs

