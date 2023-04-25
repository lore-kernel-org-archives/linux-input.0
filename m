Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB5C77B61
	for <linux-input@archiver.kernel.org>; Tue, 25 Apr 2023 09:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjDYJFk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 25 Apr 2023 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjDYJFh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2023 05:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C58C3
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2023 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682413491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2xcNS6yIqjGNizC3DyLZ1+7mKm7C0C6L/r+oz7cqk4=;
        b=GKq0dpOxbu9qRGbEqncjPXAR2XEkxpadw/XKMw+FPfU4aq5b8B1vAUkp3IXvI5lxpzptmN
        O8Ei5WHMr+qOFugd0ycyjOmbW7JBDdTilHzvPvlZl1Wp/4FAVrhQX/9gHl/IYCc/1FBr3m
        BD9LefTPtzClgRAPOXKXvcfMrNF/DJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-5vXnxFhyPEWgos0wcVILAA-1; Tue, 25 Apr 2023 05:04:48 -0400
X-MC-Unique: 5vXnxFhyPEWgos0wcVILAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CA9A800047;
        Tue, 25 Apr 2023 09:04:47 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.227.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45F7040C2064;
        Tue, 25 Apr 2023 09:04:46 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:04:43 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Mubashshir <ahmubashshir@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] staging: HID: Add ShanWan USB WirelessGamepad driver
Message-ID: <udogxn4kbihht7isswwwofra373lotxtfvyj7kwxbe3436fjsp@4yxggpana75c>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
 <fd1961a773558930b6ae0aa2f6fc7f84833ee634.1681131540.git.ahmubashshir@gmail.com>
 <20230413161305.ywthwbu3ta3mv66b@mail.corp.redhat.com>
 <3ONCTR.Q80RY3TDW2I8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ONCTR.Q80RY3TDW2I8@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Apr 19 2023, Mubashshir wrote:
> On Thu, Apr 13 2023 at 06:13:05 PM +02:00:00, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > What's the point of keeping it opened for the lifetime of the device? Do
> > you really need this?
> > 
> > >  +	if (error) {
> > >  +		dev_err(&hdev->dev, "hw open failed\n");
> > >  +		hid_hw_stop(hdev);
> > >  +		return error;
> > >  +	}
> > >  +
> > >  +	return 0;
> > >  +}
> > >  +
> > >  +static void shanwan_remove(struct hid_device *hdev)
> > >  +{
> > >  +	hid_hw_close(hdev);
> > 
> > If you can drop the last hid_hw_open/close, then you can entirely skip
> > the ->remove().
> 
> Would hid_hw_request work without open device?

No, it won't work if the device is not opened. But what's the point of
sending rumble data to the joystick if the device is not opened (so used)
by anybody? open() is called whenever a client opens the device, by
accessing the evdev node, so I think it should be fine.

Cheers,
Benjamin

