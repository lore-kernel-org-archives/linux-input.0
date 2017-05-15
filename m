From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: asus: Add support for T100 keyboard
Date: Mon, 15 May 2017 07:50:01 +0200
Message-ID: <1494827401.31900.19.camel@hadess.net>
References: <20170513195428.11445-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49675 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758229AbdEOFxt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 May 2017 01:53:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id E5B374878A8
        for <linux-input@vger.kernel.org>; Mon, 15 May 2017 07:50:05 +0200 (CEST)
In-Reply-To: <20170513195428.11445-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On Sat, 2017-05-13 at 21:54 +0200, Hans de Goede wrote:
> The ketboard dock uses with the Asus Transformer T100 series, uses
> the same vendor-defined 0xff31 usage-page as some other Asus
> keyboards. But with a small twist it has a small descriptor bug which
> needs to be fixed up for things to work.
> 
> This commit adds adds the USB-ID for this keyboard to the hid-asus
> driver and makes asus_report_fixup fix the descriptor issue, fixing
> various special function keys on this keyboard not working.

I suggest a second read of this before sending the patch again ;)
