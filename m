Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F9C4332F
	for <linux-input@archiver.kernel.org>; Tue, 20 Dec 2022 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLTJXY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiLTJXF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Dec 2022 04:23:05 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC4186AB;
        Tue, 20 Dec 2022 01:22:57 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0279D1BF20B;
        Tue, 20 Dec 2022 09:22:53 +0000 (UTC)
Message-ID: <1b466138b931e7c149551a3f5bfcf0edb4eb7932.camel@hadess.net>
Subject: Re: [PATCH] hid: Support for Litra Glow
From:   Bastien Nocera <hadess@hadess.net>
To:     Andreas Bergmeier <abergmeier@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 10:22:53 +0100
In-Reply-To: <b787798328560ef3627ba3f8634114d78d3f249a.camel@hadess.net>
References: <9fca69c7-cc24-63d0-98f6-80c28fc69a5@9300>
         <8f00ae9463b07fbd789af3840cd59a9e99caff34.camel@hadess.net>
         <b787798328560ef3627ba3f8634114d78d3f249a.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 2022-12-16 at 15:27 +0100, Bastien Nocera wrote:
> On Fri, 2022-12-16 at 10:53 +0100, Bastien Nocera wrote:
> > On Thu, 2022-12-15 at 22:09 +0100, Andreas Bergmeier wrote:
> > > Tries to implement as general support for Illumination Light as
> > > possible. Note that it is singular, which means by Logitech spec
> > > we
> > > are
> > > fine off with just handling one capability/device.
> > 
> > Your email client absolutely trashed the patch's indentation, it's
> > unreadable as-is.
> > 
> > > Implementation currently only exposes Brightness and On/Off
> > > controls.
> > > Does currently not expose Color Temperature because LEDs does not
> > > support it.
> > > 
> > > Introduces HIDPP_QUIRK_CLASS_SIMPLE_START to prevent reconnect on
> > > startup. Could not get Glow to work with that.
> > 
> > I'd really rather we didn't introduce a new quirk, but instead
> > fixed
> > the fact that we need to restart the HID transport to support 3 (!)
> > devices.
> > 
> > Would something like the attached patch work? I haven't tested it
> > yet,
> > but if it works for you, I'll test it on the devices I have here.
> 
> A tested version attached. I'll need to test it against a T650 before
> sending it for review.

I've tested it with a T650, and it works, so I sent it for review.

Would be great to know if it helps simplify your driver.

Cheers
