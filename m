From: Vladislav Naumov <vnaum@vnaum.com>
Subject: Re: [PATCH 2/2] hid: input: add HID_QUIRK_REUSE_AXES and fix dragonrise
Date: Sat, 1 Oct 2016 14:52:04 +0600
Message-ID: <CABnEwur6XnpHvpF3xOfwEkJpN13rGOvJAkpa-M5RwFFmSrhtYA@mail.gmail.com>
References: <20160926025839.2790-1-adi@adirat.com> <20160926025839.2790-2-adi@adirat.com>
 <20160926092903.GC19261@mail.corp.redhat.com> <f3f844b7-777e-41ce-4661-bcf8735763c6@gmail.com>
 <CABnEwuryj9rbeETuO+agekioq8wFd_6H0cZPCs+=Ft8c-=5j9g@mail.gmail.com>
 <874m5173ex.fsf@ni.com> <CABnEwuqXSje=Y0a49R4OfMxPvL4nAwxQqrhA+i-cce020wD90A@mail.gmail.com>
 <87y42c5j74.fsf@adirat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36605 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbcJAIwf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 04:52:35 -0400
In-Reply-To: <87y42c5j74.fsf@adirat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

I fetched `dev/aratiu/fix-dragonrise-gamepad` branch from
https://github.com/10ne1/linux
at commit a7dd8e2 "hid: hid-dr: add input mapping for axis selection"
and built 32-bit kernel (default debian config).

0079:0011 DragonRise Inc. Gamepad works properly, both axis and all buttons.

TEST PASSED.
