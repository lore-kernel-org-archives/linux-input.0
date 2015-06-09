From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH] hid: Add secondary vendor id for the marco, USB_DEVICE_ID_MS_TYPE_COVER_3_V2
Date: Tue, 9 Jun 2015 10:39:25 +0200
Message-ID: <CADscph3L+t4=T2+o3JXgRVEDn+Cfj7+sQE2s2MDgBCCZRmDUqQ@mail.gmail.com>
References: <1432138645-11540-1-git-send-email-xerofoify@gmail.com>
	<alpine.LNX.2.00.1505210129060.8186@pobox.suse.cz>
	<CABkLPOLdQwjWfY4=dVrDmVRnaSDmfUb8+X8UK0xghg6+q3Aj7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33164 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbbFIIj0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 04:39:26 -0400
In-Reply-To: <CABkLPOLdQwjWfY4=dVrDmVRnaSDmfUb8+X8UK0xghg6+q3Aj7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Wu <alan.c.wu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Nicholas Krause <xerofoify@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On 21 May 2015 at 04:40, Alan Wu <alan.c.wu@gmail.com> wrote:
> Hello Jiri,
>   I believe the patch may work, but I would rename the IDs.  Obviously
> I can't test Surface 3 non-Pro cover, but the difference is likely due
> to the following:
>
> This is 0x07dc (I do own)
> http://www.microsoftstore.com/store/msusa/en_US/pdp/Surface-Pro-Type-Cover/productID.300193600
>
> This is 0x07de (I do not own)
> http://www.microsoftstore.com/store/msusa/en_US/pdp/Surface-3-Type-Cover/productID.314885800
>
> I would rename 0x07dc to USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 (original
> submitted patch)
> and 0x07de to USB_DEVICE_ID_MS_TYPE_COVER_3 (Nicholas' patch).
>
> I would probably also rename 0x07dd to USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP.

I've got another Type Cover 3 (0x07e2 ) here, where I was going to
send a patch for. According to the small picture, it looks like a
0x07de - grey, not that glossy keys.

How should I name the define? Won't it be better to append the model
number to distinguish the Type Covers?
I've got a 0x07dc (model 1644) and 0x07e2 (model 1709).
... USB_DEVICE_ID_MS_TYPE_COVER_3_M1644
... USB_DEVICE_ID_MS_TYPE_COVER_3_M1709

The model number (pretty small) can be found on the connector above
the CE sign on the right.
