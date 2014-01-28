From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Can I limit the scope of an input device to specific processes ?
Date: Tue, 28 Jan 2014 12:15:48 +0100
Message-ID: <CANq1E4ReNtJgC7zArLo=Bo87YZXOukFTTuxjYf_nupfmUkCL+A@mail.gmail.com>
References: <S1754733AbaA1IxR/20140128085317Z+41@vger.kernel.org>
	<52E78481.6040606@UKE.Uni-Hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:47851 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbaA1LPt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jan 2014 06:15:49 -0500
Received: by mail-ig0-f175.google.com with SMTP id uq10so11785998igb.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jan 2014 03:15:49 -0800 (PST)
In-Reply-To: <52E78481.6040606@UKE.Uni-Hamburg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: R.Zimmermann@uke.uni-hamburg.de
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Jan 28, 2014 at 11:20 AM, Dr. Zimmermann
<R.Zimmermann@uke.uni-hamburg.de> wrote:
> Hi,
>
> we've got a special type of keyboard which should only be available in one
> specific process and not publicly, as usually keyboards are.
>
> Is it possible to limit the scope of a specific keyboard?
>
> Or is there a more suited forum where to ask?

There is no such interface in the kernel. However, with careful
access-management, you can get what you want by just allowing your
single process access to the device. But I guess you are working with
an X11 system, so a description of what you actually want to achieve
would help a lot.

Thanks
David
