Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3ABC433E0
	for <linux-input@archiver.kernel.org>; Mon,  4 Jan 2021 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2727D207B1
	for <linux-input@archiver.kernel.org>; Mon,  4 Jan 2021 13:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhADNeK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 4 Jan 2021 08:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADNeK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 4 Jan 2021 08:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD0AE2075B;
        Mon,  4 Jan 2021 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609767209;
        bh=I4c7ROe30YdNgNP+V87Mwg2pwOlRoGaK8v0H/UUW+6A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pe/wS1N1ArqmR3+SPZHdts9HFCLLXQTe3x7pFrz3o8m81ZUaxXz9mUV4q1xWVF9ta
         JCfWMvdi91SvxmWH5yJZ2j0HgISgQu0J7jRH8omDSPVpXdEnX1WPi7Lo+EViU+qHYP
         VWrJRq5gXHBKkNo7ewlrrx2fRsaksMm1hFa+2umiaqSSMN/BdEMIrHG1GzleoUp6k2
         SpgbmbpT5HiubUy3YupOWveTf4EPt5Yr3X4zbc5iKnDxTmjWf45L+xgOmlC+bvCmup
         zpuAru9S+J/sJSj0Z6dXf3SpBBSJYRGs6dxKmsAGktQ4/VOsePKZ+MYKYkoN+buNNd
         Mz4ILqQ9Gl3cw==
Date:   Mon, 4 Jan 2021 14:33:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: multitouch: Enable multi-input for Synaptics
 pointstick/touchpad device
In-Reply-To: <20201230124407.41186-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.2101041433140.13752@cbobk.fhfr.pm>
References: <20201230124407.41186-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 30 Dec 2020, Kai-Heng Feng wrote:

> Pointstick and its left/right buttons on HP EliteBook 850 G7 need
> multi-input quirk to work correctly.

Applied to hid.git#for-5.11/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

