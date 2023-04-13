Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88288C77B61
	for <linux-input@archiver.kernel.org>; Thu, 13 Apr 2023 15:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDMP1c (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMP13 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2023 11:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81CB479
        for <linux-input@vger.kernel.org>; Thu, 13 Apr 2023 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681399582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnisOiASzz3Ky676tiXq26Q5vpI4gZTcHYzh0pOGNiI=;
        b=Lgn1ooFMbBx1S+BNeF9TTHcS9f7zXyz+yQO32Xj4ztJoVsZLqB8xppg/N16Bkq0y1CsxJm
        RLS0tlIhQ16QLnf1toYzsUjNlo99C2kfaP7oCb5DWAYzkUPNTVSW4fEYqwx0p8KWDzEPhO
        iCAPYDWnLdAvnvCb0uNAZafFLmLOAtM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-SOo6UQapNYGK4BTKl_Rr8g-1; Thu, 13 Apr 2023 11:26:18 -0400
X-MC-Unique: SOo6UQapNYGK4BTKl_Rr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DB591C27D80;
        Thu, 13 Apr 2023 15:26:18 +0000 (UTC)
Received: from plouf.local (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF4E1121320;
        Thu, 13 Apr 2023 15:26:17 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     jikos@kernel.org, weiliang1503 <weiliang1503@gmail.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230330115638.16146-1-weiliang1503@gmail.com>
References: <20230330115638.16146-1-weiliang1503@gmail.com>
Subject: Re: [PATCH v1] HID: Ignore battery for ELAN touchscreen on ROG
 Flow X13 GV301RA
Message-Id: <168139957700.866676.9713953819672177941.b4-ty@redhat.com>
Date:   Thu, 13 Apr 2023 17:26:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 30 Mar 2023 19:56:38 +0800, weiliang1503 wrote:
> Ignore the reported battery level of the built-in touchscreen to suppress
> battery warnings when a stylus is used. The device ID was added and the
> battery ignore quirk was enabled.
> 
> 

Applied to hid/hid.git (for-6.4/core), thanks!

[1/1] HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA
      https://git.kernel.org/hid/hid/c/35903009dbde

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

