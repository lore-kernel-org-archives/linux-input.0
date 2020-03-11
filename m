Return-Path: <SRS0=Yr/4=44=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272EBC0044D
	for <linux-input@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2620736
	for <linux-input@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SayVRHZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgCKTKZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:10:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730996AbgCKTKV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Mar 2020 15:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583953820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nwAphe7Vp8zgKsBWmI405tcS4kDpAm8fbt4VH0t8ycg=;
        b=SayVRHZo+ewnJq907C7ifBNCL8gNcKia93xUo6JWCXsqp2MWrV7Uf0cIqmO+FksW9cId8a
        9L9WMjGzzu95KirH7B6X/tHHBNI/mDgC3e62zMXmczdCFri+dnN629n+V7kC8adbNSCYZc
        aghmoCcwrDGkcJdzhvGto95Ags/DSaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-D7bDBSSoOTOYisJ_MQNo7g-1; Wed, 11 Mar 2020 15:10:19 -0400
X-MC-Unique: D7bDBSSoOTOYisJ_MQNo7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D672B13E2;
        Wed, 11 Mar 2020 19:10:16 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72C0860BF1;
        Wed, 11 Mar 2020 19:10:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Mastykin <dmastykin@astralinux.ru>,
        linux-input@vger.kernel.org
Subject: [PATCH 0/1] Input: goodix - Try to reset the controller if the i2c-test fails
Date:   Wed, 11 Mar 2020 20:10:12 +0100
Message-Id: <20200311191013.10826-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

Here is a small patch fixing the goodix touchscreen driver failing at
probe due to what I consider a BIOS bug on Dmitry's Mastykin's tablet.

This patch applies on top of my earlier series starting with:
[PATCH v3 01/11] Input: goodix - Refactor IRQ pin GPIO accesses

Regards,

Hans

