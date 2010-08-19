From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
  JooJoo tablet
Date: Thu, 19 Aug 2010 23:59:17 +0200
Message-ID: <4C6DA935.1060302@bitmath.org>
References: <4C695985.5080403@bitmath.org>  <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr> <4C6A5CB2.6000603@bitmath.org> <C7CA092C-6BDD-4457-B800-606FF4C2DC9D@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:33899 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab0HSV7W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Aug 2010 17:59:22 -0400
In-Reply-To: <C7CA092C-6BDD-4457-B800-606FF4C2DC9D@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input <linux-input@vger.kernel.org>

On 08/19/2010 11:45 PM, St=E9phane Chatty wrote:

>=20
> Le 17 ao=FBt 10 =E0 11:56, Henrik Rydberg a =E9crit :
>=20
>>
>> Ah yes, the pointer emulation via ABS_X/Y. My personal view is that
>> pointer
>> emulation is a gesture, and thus best implemented in userspace.
>=20
> I agree 100% with you on this (well, I'd rather say that gestures and
> single touch emulation are two cases of input interpretation, but tha=
t's
> just my academical bias).
>=20
> However this issue was discussed last year on this list and as far as=
 I
> understood it was decided that single touch emulation was required in
> the kernel for some time...


At that time, maybe the alternatives were not as clear as they are now.=
 :-) I
think what it all means is that over time, we will see less and less of=
 the
ABS_X/Y, since we will eventually stop adding it, and hardware inevitab=
ly ages.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
