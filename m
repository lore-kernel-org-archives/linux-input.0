Return-Path: <SRS0=McSn=AP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB78C433E0
	for <linux-input@archiver.kernel.org>; Sat,  4 Jul 2020 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4AC208E4
	for <linux-input@archiver.kernel.org>; Sat,  4 Jul 2020 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6Fj+J5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGDN1w (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:27:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgGDN1v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 4 Jul 2020 09:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593869270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I/CiLnfOnKYdHbJtXmhLqHi6cG9G7Wt12d2IjAK2aLg=;
        b=X6Fj+J5o8s8QVdzEcmCzHrPLdniEQBo9XMarh9WmhD/4IsDbaeGdMgMR09wIK9laX8FExv
        xip7Iijf1FGobtJUnTC2Cm6Fk4FmRtDhbFm0lXywkFrKb0CKL224IsYuoxCDFjaHyGSqUq
        MUdv0ywqNQ2RdmdCWEQ/uWxpFzzDJmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-lRZqH7KyMdCuL5wsU10QUw-1; Sat, 04 Jul 2020 09:27:48 -0400
X-MC-Unique: lRZqH7KyMdCuL5wsU10QUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3039B1005510;
        Sat,  4 Jul 2020 13:27:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8209760BF1;
        Sat,  4 Jul 2020 13:27:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org
Subject: [PATCH 0/5] HID: lenovo: Add ThinkPad 10 Ultrabook Keyboard support
Date:   Sat,  4 Jul 2020 15:27:37 +0200
Message-Id: <20200704132742.60197-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi All,

This series really only is a small(ish) change. But I had to do some
refactoring to be able to re-use the existing (mic)mute LED and fn_lock
sysfs attribute code in hid-lenovo.c. That is done in the first 3 patches
of the series. Even though there are 5 patches all 5 of them are small and
hopefully easy to review.

Patch 4 adds the main support for the ThinkPad 10 Ultrabook Keyboard,
fixing some special keys not working and adding support for the LEDs
integrated into the mute and micmute keys.

Patch 5 adds support for modifying the Fn lock setting of the kbd through
sysfs, matching the existing ThinkPad Compact Keyboard with TrackPoint
support, which also allows modifying the Fn lock setting through sysfs.

Regards,

Hans

