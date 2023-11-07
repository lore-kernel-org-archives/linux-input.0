Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B6C4332F
	for <linux-input@archiver.kernel.org>; Tue,  7 Nov 2023 01:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjKGBjz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 6 Nov 2023 20:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBjz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Nov 2023 20:39:55 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D001B2
        for <linux-input@vger.kernel.org>; Mon,  6 Nov 2023 17:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699321189; x=1699580389;
        bh=c3hI1DNJbEAjV9T1fbWqMIYrmsWLmHVs9sTJo9Z83W4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eSUhFbULOkdhhpANv/g65icDlZe0JsgB3sVLOGdAtgq/d9JKm0Sb8aXFn3bca0Lk3
         qdActLS90Cne6F9G8DdpR0UcJN2yDljNFFVcojCrxkxco69I/Jjlscwkz7/oNylgJf
         UDwe5wLKucZ9rKZQGbUbZLYouKU1LNIN3J9hilfy7P51WymI/ysXZiKcMnEw2IjhKL
         YIpRL9QhKHR3lL5FiD62lA6WnUn6cKkEM15VTKCtBXbzwlDhX55o5C0SmeYbH2GhFr
         edh2IFV/lT+ZGb5/7Va+gkBkyNh6lTlXuCrZlwmmzGLeFtbhruwsiBjrVVLz68GHDQ
         Iv1YV7k7RVwIA==
Date:   Tue, 07 Nov 2023 01:39:43 +0000
To:     Brett Raye <braye@fastmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/2] HID: glorious: fix Glorious Model I HID report and rename vendor ID
Message-ID: <87msvq8hph.fsf@protonmail.com>
In-Reply-To: <20231106235557.8741-1-braye@fastmail.com>
References: <20231106235557.8741-1-braye@fastmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 06 Nov, 2023 15:55:55 -0800 "Brett Raye" <braye@fastmail.com> wrote=
:
> The Glorious Model I mouse presents a faulty HID report descriptor which
> prevents some of its reprogrammable buttons from working. This patch
> series performs a fixup on the faulty descriptor, and renames a vendor ID
> for consistency and clarity.

Thanks for the patches.

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

