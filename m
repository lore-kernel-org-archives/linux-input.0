From: Olivier Gay <ogay@logitech.com>
Subject: Re: [PATCH] HID: add missing hid usages
Date: Mon, 14 Apr 2014 14:22:17 +0200
Message-ID: <CAFLMSp-2qX-7LRr_m9Q=7g+zTsZ+9sp1ZR=ayO0A5ihF3th0qQ@mail.gmail.com>
References: <1396623746-1416-1-git-send-email-ogay@logitech.com> <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46341 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751341AbaDNMWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 08:22:41 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so3904559wiv.16
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2014 05:22:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Apr 7, 2014 at 9:49 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>
>
> [ adding Dmitry to CC ]
>
> On Fri, 4 Apr 2014, Olivier Gay wrote:
>
> > with this patch we add some missing hid usages to the hid system.
> > Those missing hid usages are already used by some Logitech
> > products as well as some future ones.
> >
> > (Note: checkpatch.pl shows some errors but I didn't want to
> > break the current code style in hid-input.c)
>
> Thanks for the patch, Olivier. All looking good to me, but for the input.h
> additions, I'd like to get Ack from Dmitry, hence CCing him.
>
> Dmitry, ok to take this through my tree with your ack?

Hi Dmitry,

by any chance did you take a look on this commit we submitted?

Best regards,

Olivier
