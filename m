Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB696EB64D7
	for <linux-input@archiver.kernel.org>; Wed, 21 Jun 2023 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjFUP4R (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjFUP4Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2023 11:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD1C0
        for <linux-input@vger.kernel.org>; Wed, 21 Jun 2023 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687362931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fCHQizRwe6wJfjeGABMJ7EtlC6+tAboqmFJcKVi+fI=;
        b=LJDjnXpvSBnV3jEiPhBoLaqtqQMq3v0pV2zLmWAH4AZkF4pdGmvLroOQcsIZ4GCBwISTFg
        fZvoR/ihJtC+q43dsienONVbVHVIrbK1n5iA60LgXft+toJ+xL5n/K/L6/YvwUdgNEAR2q
        lT982R4XHfvUd/AscbKm8WSqiONPiRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-Ped06gAhMRSuMJP75JcHxg-1; Wed, 21 Jun 2023 11:55:25 -0400
X-MC-Unique: Ped06gAhMRSuMJP75JcHxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33F24915180;
        Wed, 21 Jun 2023 15:55:25 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.45.224.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B81CF492B02;
        Wed, 21 Jun 2023 15:55:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix data race on device refcount
Date:   Wed, 21 Jun 2023 17:55:14 +0200
Message-Id: <168736288418.3423010.16497710719241305762.b4-ty@redhat.com>
In-Reply-To: <20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com>
References: <20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 21 Jun 2023 13:17:43 +0200, Ludvig Michaelsson wrote:
> The hidraw_open() function increments the hidraw device reference
> counter. The counter has no dedicated synchronization mechanism,
> resulting in a potential data race when concurrently opening a device.
> 
> The race is a regression introduced by commit 8590222e4b02 ("HID:
> hidraw: Replace hidraw device table mutex with a rwsem"). While
> minors_rwsem is intended to protect the hidraw_table itself, by instead
> acquiring the lock for writing, the reference counter is also protected.
> This is symmetrical to hidraw_release().
> 
> [...]

Added stable@ cc tags and

Applied to hid/hid.git (for-6.4/upstream-fixes), thanks!

[1/1] HID: hidraw: fix data race on device refcount
      https://git.kernel.org/hid/hid/c/944ee77dc6ec

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

