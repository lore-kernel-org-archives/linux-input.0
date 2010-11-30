From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] input: misc: add lps001wp_prs driver
Date: Tue, 30 Nov 2010 11:34:58 +0100
Message-ID: <AANLkTikpVtq2cQVhhcsJhZwGFW74mTqo=-vVK1e50AC2@mail.gmail.com>
References: <matteo.dameno@st.com> <1291049009-32597-1-git-send-email-matteo.dameno@st.com>
 <20101130060926.GA31838@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58534 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab0K3KfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 05:35:20 -0500
In-Reply-To: <20101130060926.GA31838@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mems applications <mems.applications@st.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, matteo.dameno@st.com, carmine.iascone@st.com, mems <mems@mems-laptopt43.corenet.prv>

On Tue, Nov 30, 2010 at 7:09 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> + =C2=A0 =C2=A0 =C2=A0If you say yes here you get support for the
>> + =C2=A0 =C2=A0 =C2=A0STM LPS001D Barometer/Termometer on I2C bus.
>
> This does not belong to input subsystem, IIO is a better fit.

According to this site:
http://www.cnbc.com/id/40413317
and its datasheet:
http://www.findmems.com/wp-content/uploads/2010/11/LPS001WP-DATASHEET.p=
df

This sensors applications are:
=E2=96=A0 Altimeter and barometer for portable devices
=E2=96=A0 Smartphones
=E2=96=A0 Indoor navigation
=E2=96=A0 GPS applications
=E2=96=A0 Weather station equipment
=E2=96=A0 Sports watches

"the same devices would be able to identify the precise location in
all three dimensions, allowing, for example, a mobile phone to send a
call to an emergency fire, medical or police service that identified
not only the location of the building but also the particular floor."
Identifying 3d location is similar to what many joystick are doing.

Specially the indoor navigation information means an information about
the user. And the information is very tied to the user.
I don't know whether this can be used to map with virtual reality in a
game, or where you use sensors data to give user informations when
visiting a museum.


Dmitry, is it possible to start putting similar drivers in a new
drivers/input/sensors directory but which belongs to the input
subsystem ? What do you think ?


i
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
