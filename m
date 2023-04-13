Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBBFC77B6E
	for <linux-input@archiver.kernel.org>; Thu, 13 Apr 2023 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDMOZx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDMOZw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2023 10:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ACA9EE3
        for <linux-input@vger.kernel.org>; Thu, 13 Apr 2023 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681395909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmSyc00c9DWDtdf0SZtLvisThkvqnKnBdKNKYb4uZos=;
        b=V4+firMjCplgtLdV4M+jEKtp5+ACmfJEKZIkiibC5kDi13+MRMFEHOQsnpDWFonmJSBy03
        RgRv3Wgj32MyVAYHH/OHVzBYqAVGxBx1/MqkYmUDVPNyA2n9kK9tP1LZpwFKk0TdgE0pL6
        lAXWPVJrOSSNYxu0ygUYxyINNoLuMWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-LGV6hamqNiqZHKRIvM73xg-1; Thu, 13 Apr 2023 10:25:06 -0400
X-MC-Unique: LGV6hamqNiqZHKRIvM73xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A66D2185A78B;
        Thu, 13 Apr 2023 14:25:05 +0000 (UTC)
Received: from plouf.local (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAA1F1121320;
        Thu, 13 Apr 2023 14:25:04 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, David Yang <mmyangfl@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230411173308.422756-1-mmyangfl@gmail.com>
References: <20230411173308.422756-1-mmyangfl@gmail.com>
Subject: Re: [PATCH] HID: kye: Fix rdesc for kye tablets
Message-Id: <168139590450.821314.15682676743353791414.b4-ty@redhat.com>
Date:   Thu, 13 Apr 2023 16:25:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 12 Apr 2023 01:33:08 +0800, David Yang wrote:
> I forget to add them in previous commit 2dd438cdc2e9
> ("HID: kye: Add support for all kye tablets").
> 
> 

Applied to hid/hid.git (for-6.4/kye), thanks!

[1/1] HID: kye: Fix rdesc for kye tablets
      https://git.kernel.org/hid/hid/c/0f6fac2cfbef

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

