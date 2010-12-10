From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Thu, 9 Dec 2010 17:29:05 -0800
Message-ID: <AANLkTimg+LJCMWCcz_jauoMxcw0OK6xudRJgPknDMDty@mail.gmail.com>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
	<AANLkTikatcsta_EQ26CzouHj+WMfQptJF_ZkMfCwUmnN@mail.gmail.com>
	<AANLkTi=w3uOQKFN3WBgzib9M0Cb143vChPPaYm6fWypi@mail.gmail.com>
	<20101209195035.GD23781@core.coreip.homeip.net>
	<AANLkTinXGX5d6-LGZjjZ9yDn_c+s7qQ7motxKjpuhaV2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44049 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713Ab0LJB3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 20:29:08 -0500
Received: by wwi17 with SMTP id 17so415379wwi.1
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 17:29:05 -0800 (PST)
In-Reply-To: <AANLkTinXGX5d6-LGZjjZ9yDn_c+s7qQ7motxKjpuhaV2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Dec 9, 2010 at 1:21 PM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Thu, Dec 9, 2010 at 1:50 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Dec 09, 2010 at 11:36:19AM -0800, Ping Cheng wrote:
>>> On Thu, Dec 9, 2010 at 7:06 AM, Chris Bagwell <chris@cnpbagwell.com=
> wrote:
>>> > On Wed, Dec 8, 2010 at 7:23 PM, Ping Cheng <pinglinux@gmail.com> =
wrote:
>>> >> @@ -228,9 +277,17 @@ static irqreturn_t w8001_interrupt(struct s=
erio *serio,
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp =3D=3D W8001_TOUCH_BYTE)
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> >>
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->has_touch) {
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* send touch data=
 out */
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->has_touch =3D=
 0;
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(d=
ev, BTN_TOUCH, 0);
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(d=
ev, BTN_TOOL_FINGER, 0);
>>> >
>>> > Probably its better to set ABS_X/ABS_Y to zero and do a sync here=
? =A0So
>>> > duplicate x/y values don't get dropped and aligns with wacom_wac.=
c.
>>> > This is related to comment about forcing ABS_X/Y to zero above. =A0=
Its
>>> > so pen has known starting point when coming in proximity. =A0I wo=
uldn't
>>> > do one without the other.
>>>
>>> I'll do both to make you happy (just kidding, to make it safe ;).
>>>
>>
>> Actually do not see how (0,0) is any safer than let's say (123,78)
>> sincve i believe (0,0) is a valid coordinate. Userspace should still
>> hang on to the last reported coordinate and use it if it did not get
>> a new one.
>>
>> Also, if you add input_sync() here won't it cause (in certain
>> situtations) false click or tap events - BTN_TOUCH goes from 1 to 0 =
and
>> then again to 1 if pen is already in proximity...
>
> The patches behavior happens to align good with existing wacom
> behavior and user land apps (xf86-input-wacom mostly) but its good to
> get this input from those not concentrating on wacom as much. =A0It
> helps remind me the old way is not the only way.
>
> Let me answer the second point first.
>
> The above code is following a kinda rule that other wacom tablet
> drivers obey. =A0That rule is that if 2 tools share ABS_* events then
> only 1 of those tools can be in proximity at one time. =A0If a driver
> follows that rule then you will not get the unwanted clicks you
> mention.
>
> The 1 tool in proximity probably originates from physical attribute o=
f
> having to flip pen to get eraser or switching to another physical
> stylus. =A0I think it wasn't until touch+stylus that HW supported 2
> tools in proximity with same ABS_*. =A0The above logic comes in to
> simulate older HW enforced behavior. =A0There is some user land code =
I
> know of that depends on that rule right now but easy enough to fix (b=
y
> buffering last (x,y,touch) values).
>
> For first point, your right that (123,78) is just a good "known
> starting value" if a driver is going to use that concept because it
> could be filtered just as easy as (0,0). =A0Its the "known" part that=
s
> more useful to userland. =A0They can do a memset() when entering
> proximity instead of buffering previous values.
>
> I think this part of past driver behavior originated because, before
> touch tools, wacom hardware was good about sending (x,y,touch) as
> (0,0,0) when tool was out of proximity and this behavior came out to
> userland without driver doing anything. =A0For touch case, software
> driver must simulate older hardware behavior. =A0Again, I happen to k=
now
> some userland code that came to depend on that (0,0,0) but its easy
> enough to fix.
>
> So the overall patch is in line with existing multi-tool wacom tablet=
s
> and their code flow.
>
> My original comment can be restated as if you going to send
> BTN_TOUCH=3D0 then probably you should send ABS_X/Y=3D0 for consisten=
cy
> with other wacom behavior.

So, do you mean if we do not send BTN_TOUCH=3D0, we do not need to send
ABS_X/Y=3D0? That is we only need to send BTN_TOOL_FINGER=3D0?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
