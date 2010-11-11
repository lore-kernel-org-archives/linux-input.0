From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 13:25:24 -0800
Message-ID: <AANLkTi=TVm1xUeM8nfnGFhyrjW9+3NL0AO9iCvVFTriZ@mail.gmail.com>
References: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
	<AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
	<20101110050219.GB29110@barra.bne.redhat.com>
	<4CDA6D25.4070501@euromail.se>
	<20101110235355.GB4473@barra.bne.redhat.com>
	<4CDB3D6C.2000507@euromail.se>
	<20101111012251.GC2121@core.coreip.homeip.net>
	<AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
	<20101111082653.GC24415@core.coreip.homeip.net>
	<AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
	<20101111192434.GA13163@core.coreip.homeip.net>
	<4CDC46E5.8040703@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38059 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0KKVZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 16:25:25 -0500
Received: by wyb28 with SMTP id 28so1153390wyb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 13:25:24 -0800 (PST)
In-Reply-To: <4CDC46E5.8040703@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 11:41 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>
> Right. Perhaps this is a good time to discuss some additional helper =
functions
> Chris and myself are playing with right now.
>
> /**
> =A0* input_mt_report_state() - report contact state
> =A0* @dev: input device with allocated MT slots
> =A0* @active: true if contact is active, false otherwise
> =A0*
> =A0* Reports an active touch via ABS_MT_TRACKING_ID. If active is
> =A0* true and the slot is currently inactive, a new tracking id is
> =A0* assigned to the slot.
> =A0*/
> void input_mt_report_state(struct input_dev *dev, bool active);
>
> Since all tracking-capable drivers we have seen so far have a contact=
 id with
> the same semantics as the slot id, it makes sense to have the above f=
unction to
> remove the need for individual drivers to assign tracking ids.
>
> With the input core (or input-mt.c) controlling the tracking id, it i=
s easy to
> add more goodness, such as

I agree that centralizing the common code is a good way to go.


> /**
> =A0* input_mt_report_pointer_emulation() - common pointer emulation
> =A0* @dev: input device with allocated MT slots
> =A0*
> =A0* Performs legacy pointer emulation via BTN_TOUCH, etc.
> =A0*/
> void input_mt_report_pointer_emulation(struct input_dev *dev);
>
> Since the input device knows the MT state and what buttons and abs ax=
es are in
> use, it can provide the right set of data to emit to emulate pointer =
and touch
> events. The track-oldest-contact logic can be readily implemented.

Are we going to do the tocuh and pen aribtration in input-mt.c? I need
to understand this to make my patches.

Sounds a bit complicated if we do the aribtration here, considering
the differences between pen and tocuh. If not, we will need to tell
input_mt_report_pointer_emulation if another tool (such as pen) has
already sent pointer events. That is input_mt_report_pointer_emulation
is only called when needed.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
