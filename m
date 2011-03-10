From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: FW: [Bug 30792] New: MosArt touchscreen relative motion since
 kernel upgrade
Date: Thu, 10 Mar 2011 10:40:00 +0100
Message-ID: <AANLkTi=q=sXT0tO0p4kBOe7PGwi-4sFS++1o6yRkBJcr@mail.gmail.com>
References: <20110309195350.GA9604@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42967 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1CJJkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 04:40:02 -0500
Received: by wya21 with SMTP id 21so1270457wya.19
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2011 01:40:01 -0800 (PST)
In-Reply-To: <20110309195350.GA9604@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: james.sharam@gmail.com, Linux Input <linux-input@vger.kernel.org>

Hi Dmitry,

James already contacted me, and I sent him the solution. This will be
fixed in stable too.
As James mentioned on the bugzilla, this bug can be marked as closed.

Cheers,
Benjamin

On Wed, Mar 9, 2011 at 20:53, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
> Forwarding since Benjamin does not seem to have bugzilla account...
>
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org ----=
-
>
> Date: Wed, 9 Mar 2011 10:25:31 GMT
> From: bugzilla-daemon@bugzilla.kernel.org
> To: dmitry.torokhov@gmail.com
> Subject: [Bug 30792] New: MosArt touchscreen relative motion since ke=
rnel upgrade
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D30792
>
> =A0 =A0 =A0 =A0 =A0 Summary: MosArt touchscreen relative motion since=
 kernel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0upgrade
> =A0 =A0 =A0 =A0 =A0 Product: Drivers
> =A0 =A0 =A0 =A0 =A0 Version: 2.5
> =A0 =A0Kernel Version: 2.6.37.2 and 2.6.37.3
> =A0 =A0 =A0 =A0 =A0Platform: All
> =A0 =A0 =A0 =A0OS/Version: Linux
> =A0 =A0 =A0 =A0 =A0 =A0 =A0Tree: Mainline
> =A0 =A0 =A0 =A0 =A0 =A0Status: NEW
> =A0 =A0 =A0 =A0 =A0Severity: normal
> =A0 =A0 =A0 =A0 =A0Priority: P1
> =A0 =A0 =A0 =A0 Component: Input Devices
> =A0 =A0 =A0 =A0AssignedTo: drivers_input-devices@kernel-bugs.osdl.org
> =A0 =A0 =A0 =A0ReportedBy: james.sharam@gmail.com
> =A0 =A0 =A0 =A0Regression: No
>
>
> I have a laptop with a MosArt touchscreen and since upgrading to 2.6.=
37.2 it
> hasn't been behaving correctly.
>
> Motion since the update is relative rather than absolute. For example=
, when I
> touch part of the screen, nothing happens, the cursor doesn't jump to=
 where my
> finger presses. However, when I touch the screen and drag my finger t=
he mouse
> moves around in the same direction as my finger moves, but doesn't mo=
ve to
> where my finger is.
>
> It seems to be behaving like a touchpad rather than like a touchscree=
n.
>
> I think this is related to commit c64f6f934c7490faff76faf96217066a1b3=
570a0
> which changes over the driver for the touchscreen to use hid-mosart.
>
> Is this likely to be a configuration issue with the new driver or a b=
ug in the
> driver?
>
> Thanks.
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Dem=
ail
> ------- You are receiving this mail because: -------
> You are watching the assignee of the bug.
>
> ----- End forwarded message -----
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
