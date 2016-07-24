From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/8] Input: synaptics-rmi4: Add dribble and palm
 gesture parameters to device tree
Date: Sun, 24 Jul 2016 16:29:23 +0200
Message-ID: <CACRpkdZp2htovazproVH9eeAr6bwE32hP4w2=jV-M68B5p0CNg@mail.gmail.com>
References: <1468476522-8032-1-git-send-email-aduggan@synaptics.com>
 <20160722165239.GA5036@dtor-ws> <682368c2-5692-5905-7538-36ce2e3d262f@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34350 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbcGXO3Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jul 2016 10:29:24 -0400
Received: by mail-oi0-f45.google.com with SMTP id l65so221452146oib.1
        for <linux-input@vger.kernel.org>; Sun, 24 Jul 2016 07:29:24 -0700 (PDT)
In-Reply-To: <682368c2-5692-5905-7538-36ce2e3d262f@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>

On Fri, Jul 22, 2016 at 8:32 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> If the firmware was configured incorrectly it might just be easier to add a
> device tree entry. This would allow platform owners to make the change
> without having to get Synaptics involved or have access to our tools.
> Customers have also requested using the same module and firmware across
> multiple platforms. Tracking which firmware is on which part would create an
> additional support burden and not all platforms have an automated way of
> checking and updating firmware versions in the event that a system is build
> with a module which has the incorrect firmware.

I think it's a valid argument.

That said, the world needs more of
drivers/scsi/aic7xxx

That driver has the firmware generation, including an assembler, in the
kernel tree. Pretty cool eh?

(I know it is a thick thing to ask, just want to give you an idea of what
is possible...)

Yours,
Linus Walleij
