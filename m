From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: enable the Surface 4 Type Cover Pro
 (JP) to report multitouch data
Date: Thu, 15 Dec 2016 09:26:34 +0100
Message-ID: <20161215082634.GC31881@mail.corp.redhat.com>
References: <OSXPR01MB0791C4F683C0E619C7660BEEF29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbcLOI0i (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 03:26:38 -0500
Content-Disposition: inline
In-Reply-To: <OSXPR01MB0791C4F683C0E619C7660BEEF29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuta Kobayashi <alu.ula@outlook.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Dec 15 2016 or thereabouts, Yuta Kobayashi wrote:
> From: Yuta Kobayashi <alu.ula@outlook.com>
> 
> Signed-off-by: Yuta Kobayashi <alu.ula@outlook.com>
> ---
>  drivers/hid/hid-core.c          | 2 --
>  drivers/hid/hid-ids.h           | 1 -
>  drivers/hid/hid-microsoft.c     | 2 --
>  drivers/hid/usbhid/hid-quirks.c | 1 -
>  4 files changed, 6 deletions(-)

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

