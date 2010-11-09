From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Tue, 9 Nov 2010 07:07:52 -0500
Message-ID: <AANLkTinXFGt7CZDQwMzk51d_1JsqJ5H1zgebgUzoZzPQ@mail.gmail.com>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
	<20101107060147.GC3823@core.coreip.homeip.net>
	<AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
	<4CD7F6A7.8040206@redhat.com>
	<AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
	<AANLkTimPKkvdWWTPoWGCRmp-biwup1dEQpaKYEk8t9ED@mail.gmail.com>
	<4CD805D8.2000808@redhat.com>
	<20101109063242.GA10496@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40691 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab0KIMHw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 07:07:52 -0500
Received: by pzk28 with SMTP id 28so1236896pzk.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 04:07:52 -0800 (PST)
In-Reply-To: <20101109063242.GA10496@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

On Tue, Nov 9, 2010 at 1:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Nov 08, 2010 at 12:14:48PM -0200, Mauro Carvalho Chehab wrote:
>> Em 08-11-2010 11:41, jonsmirl@gmail.com escreveu:
>> > On Mon, Nov 8, 2010 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> >> To achieve plug and play at least one of four choices has to happen:
>> >
>> > There is another option, the IR maps get integrated into user space
>> > keyboard mapping package. This may be possible with the new
>> > libxkbcommon package.
>>
>> That seems interesting.
>>
>
> I disagree here. libxkbcommon provides X interface while applications

You are assuming that libxkbcommon stays X specific. I'm pushing to
turn it into a generic keymapping solution. Wayland sure doesn't want
to inherit all of the baggage of X keymaps. This is also an
opportunity to address internationalization at the console level. This
is an opportunity to clean up the whole key mapping mess in user
space.

Writing a generic keymapping library is a good project if someone is
looking for something to do. It's not too complicated since you can
use libxkbcommon as guidance.

> might want to access evdev nodes directly. If anything, parts of
> ir-utils dealing with keymap selection should be moved into udev. Maybe
> we should split utilities that select protocol from the keymap setting
> and use udev keymap utilities to do the task.
>
> Thanks.
>
> --
> Dmitry
>



-- 
Jon Smirl
jonsmirl@gmail.com
