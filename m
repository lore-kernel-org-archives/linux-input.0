From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch unification
Date: Mon, 10 Jan 2011 20:24:12 +0100
Message-ID: <AANLkTi=BoBPZ-KxAn9NSECVv+7FB9DBTu5nchS3TN-rT@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1101072355200.26685@pobox.suse.cz>
	<alpine.LNX.2.00.1101072359450.26685@pobox.suse.cz>
	<alpine.LNX.2.00.1101082224130.26685@pobox.suse.cz>
	<alpine.LNX.2.00.1101101931200.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41463 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab1AJTYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 14:24:13 -0500
In-Reply-To: <alpine.LNX.2.00.1101101931200.26685@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 10, 2011 at 7:32 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 8 Jan 2011, Jiri Kosina wrote:
>
>> > > I have now applied the patchset as-is to the 'multitouch' branch=
 in my
>> > > tree.
>> >
>> > Which means -- could you please send any followup patches on top o=
f that
>> > branch (i.e. on top of the v3 patchset)? It would help my workflow=
 and
>> > make the merging process smoother.
>>
>> 'multitouch' brach now builds, as Linus has taken Dmitry's pull requ=
est
>> and I have merged from Linus.
>>
>> So once you have fixed for the minor issues raised by Henrik and onc=
e you
>> have finished your testing, please send the additional fixes to me a=
nd I
>> will be merging the branch upstream.
>
> Hi Benjamin,
>
> we are now slowly aproaching the point in time in which I would like =
to
> prepare second round of HID tree merge with Linus.
>
> Have you finished your testing / fixing the minor issues raised by He=
nrik
> please?
>
> Thanks,
>

Hi Jiri,

I'm still waiting for one tester (the generaltouch one).

I hope he will be able to test it tomorrow (he told me he was busy unti=
l today).

I'm sure the driver works for two of the three devices (we have them
at the lab). The generaltouch is less important as there is a conflict
in the naming of the vendorID/deviceID:
GeneralTouch sells two different devices with the same deviceID, and
the older is handled by usbtouchscreen.
St=E9phane explained to me today that people that want to use multitouc=
h
features will have to do some manipulations to enable it.

I'll send the diff between v3-v4 tomorrow if you want or before if you
really need.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
