From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in  JooJoo tablet
Date: Tue, 17 Aug 2010 13:34:00 +0200
Message-ID: <FDB1F269-49AF-4985-BD0F-869D23833D2B@enac.fr>
References: <4C695985.5080403@bitmath.org>  <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr> <1282042502.13264.21.camel@mini>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.intuilab.com ([93.93.42.171]:54677 "EHLO
	zimbra.intuilab.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab0HQLmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 07:42:21 -0400
In-Reply-To: <1282042502.13264.21.camel@mini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input <linux-input@vger.kernel.org>


Le 17 ao=FBt 10 =E0 12:55, Chase Douglas a =E9crit :

> On Tue, 2010-08-17 at 09:49 +0200, St=E9phane Chatty wrote:
>> Le 16 ao=FBt 10 =E0 17:30, Henrik Rydberg a =E9crit :
>>
>>   - the single touch emulation is highly device dependent. I was (an=
d
>> still am) pretty proud of my choice of tracking the 'oldest' finger
>> on the panel: this turns multitouch panels into single touch panels
>> that are impervious to parasite touches. But the drawback is that
>> currently there is no generic method for this tracking: I used
>> whatever device-specific information I could use (order of fingers i=
n
>> a message, tracking id, etc).
>
> St=E9phan,
>
> Can you explain in more detail why you chose an 'oldest' finger =20
> approach
> for single touch emulation? I wonder if it's the best mechanism. Take
> the following example:
>
> 1. User touches with one finger and intends to drag an object on =20
> screen
> 2. User touches another finger down, either accidentally or
> intentionally, while dragging the first finger
> 3. User releases first finger to end the drag
> 4. Object suddenly is dragged under the second finger
>
> As I'm implementing support for the Magic Trackpad right now, I'm =20
> having
> to figure out the best way to do single-touch emulation. What I'm
> currently doing is converting the first finger touched for single-=20
> touch
> emulation, and when that finger is released no single-touch emulation
> can occur until all fingers have left the screen again.

Yes, the debate is what to do when the 'actual oldest' finger is =20
released: should the 'second oldest' take its place or should this be =20
a release or should somthing else occur.

Some arguments in favour of the first option:
- My experience is that 'accidental' touches are transient. =20
Therefore, the conjunction of having an accidental touch and a =20
release is not very frequent.
  - At the opposite, on very large screens, it may sometimes be =20
comfortable to "replace one finger with another", thus 'moving' the =20
dragged object from one hand to the other.

More or less, the debate is about statistics and user experience =20
design...

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
