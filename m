Return-Path: <SRS0=b+LQ=EB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52AC2D0A3
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530A622450
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603702641;
	bh=yTpQBRt8io3u+omzEdBzYYJ0iLVCioSxzSrUglBEKTA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=DszxRLhLyDPSsT677/FQ+PQeq78XKdtb/03DzmVfqKFDCp2JbMi/IHC0GX58xnlts
	 F9DLp/xbvD0ty4KD4oQDXD5h05IW6R76c79jRjSFRk35rarZWs6Ht36ujo0rbmJpcZ
	 pPwOYBSrNoKkyinwEAnLxoxOp0KRSRl26CgC+gSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772351AbgJZI5U (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772342AbgJZI5T (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Oct 2020 04:57:19 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3522242A;
        Mon, 26 Oct 2020 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603702639;
        bh=yTpQBRt8io3u+omzEdBzYYJ0iLVCioSxzSrUglBEKTA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mRb4rP3UoCVv2iWrKuumXqe9tef3dneCTrCpkMTaH7Vn3AyIIkRa82g/ehPEYE5ho
         QdrArBrDvJ3YATadWuIpkxCnrX0uikMZAXn5u8RyL4gxQx6C7JVkixc+YGFQkI419g
         eevBljf0mV0oTBDP7XET7U4FV1pN4Onbf8BUaGTo=
Date:   Mon, 26 Oct 2020 09:57:15 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, jic23@kernel.org,
        Nehal-bakulchandra.Shah@amd.com, mail@richard-neumann.de,
        Shyam-sundar.S-k@amd.com, lipheng@hanmail.net
Subject: Re: [PATCH v2] AMD_SFH: Fix for incorrect Sensor index
In-Reply-To: <20201024064742.763600-1-Sandeep.Singh@amd.com>
Message-ID: <nycvar.YFH.7.76.2010260956430.18859@cbobk.fhfr.pm>
References: <20201024064742.763600-1-Sandeep.Singh@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 24 Oct 2020, Sandeep Singh wrote:

> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Add fix for incorrect sensor index and minor code clean-up.

Please be more specific in the changelog -- what is the problem it is 
fixing, how is it fixing it, etc.

Thanks,

-- 
Jiri Kosina
SUSE Labs

