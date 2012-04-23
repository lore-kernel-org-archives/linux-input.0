From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv3 1/2] drivers: input: keypad: Add device tree support
Date: Mon, 23 Apr 2012 21:10:45 +0530
Message-ID: <CAKdam541af1bU8_64gTZva9VS0R3dTR=3L3J50o9HgHH+WaPYQ@mail.gmail.com>
References: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>
	<4F95749E.40708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36264 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753028Ab2DWPks (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:40:48 -0400
Received: by wgbdq10 with SMTP id dq10so7871188wgb.5
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 08:40:45 -0700 (PDT)
In-Reply-To: <4F95749E.40708@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>

Hi Stephen,

On Mon, Apr 23, 2012 at 8:56 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/23/2012 09:27 AM, Sourav Poddar wrote:
>> Update the Documentation with omap4 keypad device tree
>> binding information.
>> Add device tree support for omap4 keypad driver.
>
> Shouldn't this use the already-defined matrix keyboard bindings at
> Documentation/devicetree/bindings/input/matrix-keymap.txt?
>
True, that is one way of describing the linux-keymap, but i think it can be
done  either ways.

Are you hinting at getting rid of Documentation for each seperate modules and
just use a single  Documentation/devicetree/bindings/input/matrix-keymap.txt?


> (I asked this before, but don't recall seeing any response explaining
> why a new binding was needed. Sorry if I missed it.)
Sorry, It was  I  who missed it.

~Sourav
