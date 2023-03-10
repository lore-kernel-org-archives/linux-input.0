Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407FC64EC4
	for <linux-input@archiver.kernel.org>; Fri, 10 Mar 2023 14:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjCJOXI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 10 Mar 2023 09:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjCJOWa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2023 09:22:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3335311ABBB;
        Fri, 10 Mar 2023 06:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A705BB82291;
        Fri, 10 Mar 2023 14:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32146C4339E;
        Fri, 10 Mar 2023 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678458110;
        bh=jcQlVbYJMOn0q9l0MPqOqOqXFxZpQLqlK9jqO58IPWc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HKx5GH/a+uce16kTYa4aU3HDTpbLcqxGz/7WD/Og2uUe4d5yC1mIIzM56L9WkWi8r
         NmKduebE3zbG1jLsZS9l7obxQ4r3anecpecl90wUT+FxhcIOU7ivSIVz+IFiKmBQkE
         9zX4123VtncIme5ZRNUeUEZKKZ6alsAtncBcrT8rs+x0UuVuea6pO8nG11HcenuVGQ
         RKJaDvYuR2FKPMly5fmzm9pXLm3bKLpnczLcKt7IPDWlWek5yumnxdZg5E7ng8MJFS
         +K23SAo+hKV+GvExowzYYvun5IroCshowDJUz6ZavZZR6B7vWRk8YJoZPRgxKzW3HL
         7hQ4BoSWFfhig==
Date:   Fri, 10 Mar 2023 15:21:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Qi Feng <fengqi706@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
In-Reply-To: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
Message-ID: <nycvar.YFH.7.76.2303101521430.1142@cbobk.fhfr.pm>
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 16 Feb 2023, Qi Feng wrote:

> From: fengqi <fengqi@xiaomi.com>
> 
> Our HID device need KEY_CAMERA_FOCUS event to control camera,
> but this event is non-existent in current HID driver.
> So we add this event in hid-input.c.
> 
> Signed-off-by: fengqi <fengqi@xiaomi.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

