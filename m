From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Change the hover event from MT to ST
Date: Wed, 8 Jul 2015 16:11:52 -0700
Message-ID: <20150708231152.GA379@dtor-ws>
References: <7389F224-E5E4-4DA0-A70F-4CBB70F53F2E@emc.com.tw>
 <20150707180624.GD12491@dtor-ws>
 <CAN+gG=HVWMZ8pACY+bBO=7w3i85J0snw6PYGJfcVOOWgMbf4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36065 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbGHXL5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2015 19:11:57 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=HVWMZ8pACY+bBO=7w3i85J0snw6PYGJfcVOOWgMbf4TA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: duson <dusonlin@emc.com.tw>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Wed, Jul 08, 2015 at 06:58:36PM -0400, Benjamin Tissoires wrote:
> On Tue, Jul 7, 2015 at 2:06 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Jul 07, 2015 at 01:37:14PM +0800, duson wrote:
> >> We want the hover event like BTN_LEFT, even no contract object,
> >> it still can be reported to upper OS system.
> >>
> >> Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> >
> > Applied, thank you.
> 
> Sorry for waking up too late but I am not sure we want this patch.
> 
> Why do we need to remove the ABS_MT_DISTANCE bits? I can understand
> that we would want to to have ABS_DISTANCE for the pointer emulation,
> but removing the per-finger information does not make much sense.
> libinput knows now how to deal with per-finger hovering through
> ABS_MT_DISTANCE, and you are just breaking the touchpad/screens with
> this patch.

Because the device does not provide per-finger information about
hovering. It can only tell that there is "something" hovering over the
surface, but it doe snot provide the data that there are 2 fingers
hovering or that finger 1 was in contact but now is hovering, etc.

Thanks.

-- 
Dmitry
