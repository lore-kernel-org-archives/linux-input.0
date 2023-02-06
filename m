Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F5C61DA4
	for <linux-input@archiver.kernel.org>; Mon,  6 Feb 2023 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBFNcE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 6 Feb 2023 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBFNcA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2023 08:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F6241EB
        for <linux-input@vger.kernel.org>; Mon,  6 Feb 2023 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675690268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPpoCAzy3QGdRF5CjYYrnG2pjs3nd8X+mOalE/GKH1k=;
        b=CRYfxYM7mQ35Ru17gTmOGRx6dIZ4RAkTQ0tKzXZOn0PY0WVN0JemQzGE/18GD9DriXIWcI
        uP3N16v9kd9dRdo43WjVukReo02/w9es0r+PjAQg3tGz6rd2mHPxodoR5UHY2NAsfBjsrz
        pTHvNDrmCP+QK83DRXomtJWMYd9WPmY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-wkXYcvevOO-JkyuVoZzCPA-1; Mon, 06 Feb 2023 08:31:04 -0500
X-MC-Unique: wkXYcvevOO-JkyuVoZzCPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C73B81C05147;
        Mon,  6 Feb 2023 13:31:03 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B88492B21;
        Mon,  6 Feb 2023 13:31:01 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Tobias Klausmann <klausman@schwarzvogel.de>,
        stable@vger.kernel.org
In-Reply-To: <20230203101800.139380-1-hadess@hadess.net>
References: <20230203101800.139380-1-hadess@hadess.net>
Subject: Re: [PATCH] HID: logitech: Disable hi-res scrolling on USB
Message-Id: <167569026165.2830974.5581534197133188329.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 14:31:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 03 Feb 2023 11:18:00 +0100, Bastien Nocera wrote:
> On some Logitech mice, such as the G903, and possibly the G403, the HID
> events are generated on a different interface to the HID++ one.
> 
> If we enable hi-res through the HID++ interface, the HID interface
> wouldn't know anything about it, and handle the events as if they were
> regular scroll events, making the mouse unusable.
> 
> [...]

Applied to hid/hid.git (for-6.2/upstream-fixes), thanks!

[1/1] HID: logitech: Disable hi-res scrolling on USB
      https://git.kernel.org/hid/hid/c/690eb7dec72a

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

