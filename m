Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FCEB64DA
	for <linux-input@archiver.kernel.org>; Mon, 19 Jun 2023 14:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFSOkJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFSOkI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2023 10:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F3A0
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687185562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPCZN70tN1zqnA50yW/H0x9SLuLi5BEKqWDkIpt1ddo=;
        b=Di0vF25y+pe4pPfml2u+dLOwBSW65UUYI2bMWYino309nBZl9Ac9pqsfLK8CXW0p3OD7az
        SfQf+YUxwo9jvpUE3+oBb/lZxD76uTwl6kygw1nV7tmptWZULOjr3ugc0tnhxXNbU4SibT
        DSAORcN75bkpmc10Y6cqWA5RKLITJ/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-IZm6hcveNwue3xxU7IQS8Q-1; Mon, 19 Jun 2023 10:39:19 -0400
X-MC-Unique: IZm6hcveNwue3xxU7IQS8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F61185A795;
        Mon, 19 Jun 2023 14:39:19 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.225.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F20482026D49;
        Mon, 19 Jun 2023 14:38:38 +0000 (UTC)
Date:   Mon, 19 Jun 2023 16:38:36 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, Mike Hommey <mh@glandium.org>
Cc:     Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for
 the T651.
Message-ID: <fgjrjcwtpdhkmvrj6a5qnq32patasjyhuq6jef36uxnbrk6brb@ngkm67wkh4vv>
References: <20230617230957.6mx73th4blv7owqk@glandium.org>
 <168718531736.2920085.7885355785622180367.b4-ty@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168718531736.2920085.7885355785622180367.b4-ty@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


On Jun 19 2023, Benjamin Tissoires wrote:
> 
> On Sun, 18 Jun 2023 08:09:57 +0900, Mike Hommey wrote:
> > 498ba20690357691103de0f766960355247c78be put restarting communication
> > behind that flag, and this was apparently necessary on the T651, but the
> > flag was not set for it.
> > 
> > 

Thanks for spotting this. I've amended the commit message to make
checkpatch.pl happier, and added the cc stable tags.

Cheers,
Benjamin

> 
> Applied to hid/hid.git (for-6.4/upstream-fixes), thanks!
> 
> [1/1] HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.
>       https://git.kernel.org/hid/hid/c/5fe251112646
> 
> Cheers,
> -- 
> Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

