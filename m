Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC6AC433FE
	for <linux-input@archiver.kernel.org>; Fri,  4 Nov 2022 08:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKDIgl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Nov 2022 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDIgk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 4 Nov 2022 04:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D39111C;
        Fri,  4 Nov 2022 01:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EA4EB82BE6;
        Fri,  4 Nov 2022 08:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3994C433C1;
        Fri,  4 Nov 2022 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667550997;
        bh=47FBA33VGpTyXxdfNI47sIEI5c7uBK+g44tvgfL+w5Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MTygu3Ms9uz5CYlM0ARFuZA6GWVZY1A84c0NRPvMib94hwxcW25YSkvCPktiLIQIa
         C/1b1GZlT+4xKn84AdlaGt18H+ldCNoPbcl9Qa0Wx3WBtHcjmJgEJ8AzE4RwvskYsi
         dHe5HReiaCLHfGO6LmN0eNzIUmy2rHERBXDJF9TyJE4F2o+AIVhFNILSIFMQdYoGnM
         K8LNZsTeHGmD6D0+AMl9dNXC3AFAbvicPrMcbdVX1n7pOgGmvjOl6Cm9xvPFLSWvzv
         dx0Ce9aeyff8rc5wVoWP3BiwHneomEZad5Xx3hzNrx5ZzyYb4mKEETWM/bReF0wV9t
         SeJKPgBPw1aqA==
Date:   Fri, 4 Nov 2022 09:36:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Eray_Or=E7unus?= <erayorcunus@gmail.com>
cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, ike.pan@canonical.com,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com
Subject: Re: [PATCH v2 2/7] HID: add mapping for camera access keys
In-Reply-To: <20221029120311.11152-3-erayorcunus@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211040936220.29912@cbobk.fhfr.pm>
References: <20221029120311.11152-1-erayorcunus@gmail.com> <20221029120311.11152-3-erayorcunus@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 29 Oct 2022, Eray Orçunus wrote:

> HUTRR72 added 3 new usage codes for keys that are supposed to enable,
> disable and toggle camera access. These are useful, considering many
> laptops today have key(s) for toggling access to camera.
> 
> This patch adds new key definitions for KEY_CAMERA_ACCESS_ENABLE,
> KEY_CAMERA_ACCESS_DISABLE and KEY_CAMERA_ACCESS_TOGGLE. Additionally
> hid-debug is adjusted to recognize this new usage codes as well.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

