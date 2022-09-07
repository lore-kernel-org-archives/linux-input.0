Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A3EC6FA8A
	for <linux-input@archiver.kernel.org>; Wed,  7 Sep 2022 15:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIGPlN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGPlM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2022 11:41:12 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4139C21A;
        Wed,  7 Sep 2022 08:41:10 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 04C0D40004;
        Wed,  7 Sep 2022 15:41:08 +0000 (UTC)
Message-ID: <661ee8227c96aeba7aae9fff6ac9a73f1d81e765.camel@hadess.net>
Subject: Re: [PATCH v5 2/4] Input: joystick: xpad: Add ABS_PROFILE axis
 value to uapi
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com
Date:   Wed, 07 Sep 2022 17:41:08 +0200
In-Reply-To: <Yw0OjoVzKV3QOYah@ghaven-kernel>
References: <20220825222420.6833-1-nate@yocom.org>
         <20220825222420.6833-3-nate@yocom.org>
         <3e48ef8d13337ce1c3ec68baffc612fde4740b0e.camel@hadess.net>
         <Yw0OjoVzKV3QOYah@ghaven-kernel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 2022-08-29 at 12:07 -0700, Nate Yocom wrote:
> On Sat, Aug 27, 2022 at 12:40:46PM +0200, Bastien Nocera wrote:
> > On Thu, 2022-08-25 at 15:24 -0700, Nate Yocom wrote:
> > > Add an ABS_PROFILE axis for input devices which need it, e.g. X-
> > > Box
> > > Adaptive Controller and X-Box Elite 2.
> > > ---
> > >  include/uapi/linux/input-event-codes.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/input-event-codes.h
> > > b/include/uapi/linux/input-event-codes.h
> > > index dff8e7f17074..7ad931a32970 100644
> > > --- a/include/uapi/linux/input-event-codes.h
> > > +++ b/include/uapi/linux/input-event-codes.h
> > > @@ -862,6 +862,7 @@
> > >  #define ABS_TOOL_WIDTH         0x1c
> > >  
> > >  #define ABS_VOLUME             0x20
> > > +#define ABS_PROFILE            0x21
> > >  
> > >  #define ABS_MISC               0x28
> > >  
> > 
> > 
> > You probably also want to add it to the absolutes array in
> > drivers/hid/hid-debug.c.
> 
> doh, roger.
> 
> > Again, you might want to wait for confirmation from Dmitry that
> > this is
> > the right way to do this for the profiles.
> 
> Makes sense.  Dmitry?

Dmitry, could you please confirm whether ABS_PROFILE definition is
correct?

Then Nate can update his patch so we can land the support for that
controller.

Thanks!
