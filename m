From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/2] HID: usbhid: Add HID_QUIRK_NO_INIT_REPORTS for Oculus
 Rift CV1
Date: Thu, 8 Jun 2017 09:22:45 +0200
Message-ID: <CA+gwMccJqUfKdnyQfyaMWvBBY5rdZS_cmfy_j+Xem5KwX4PXKA@mail.gmail.com>
References: <20170607055435.25988-1-philipp.zabel@gmail.com>
 <20170607055435.25988-2-philipp.zabel@gmail.com> <20170607071100.GC16591@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33838 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdFHHWw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 03:22:52 -0400
In-Reply-To: <20170607071100.GC16591@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, linux-usb <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Benjamin,

On Wed, Jun 7, 2017 at 9:11 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Philip,
>
> On Jun 07 2017 or thereabouts, Philipp Zabel wrote:
[...]
> 2 things:
> - the 2 patches should be squashed together. There is no point having a
>   single patch for just 2 defines not used anywhere else.
> - I believe you don't even need this quirk in the development version of
>   the hid tree. Would you mind trying a plain v4.12-rcX and report if
>   you still need the quirk?

Thanks, you are right. I just checked on v4.12-rc4 and now it works without
the quirk. Sorry for the noise.

regards
Philipp
