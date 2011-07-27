From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/3] hid-multitouch: Filter collections by application  usage.
Date: Wed, 27 Jul 2011 14:43:42 +0200
Message-ID: <EF6EC882-8649-44B3-97A2-3E69D0D4DCAA@enac.fr>
References: <1311545261-34067-1-git-send-email-jeffbrown@android.com><131154 5261-34067-2-git-send-email-jeffbrown@android.com><13989665-31A9-4C70-B578- 5559987CC9F5@enac.fr> <CAN+gG=FAFX-N-3FpAmgkE+im4oT9h657Rk9h3=-17sCBwVx35A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:54943 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1G0Mnp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 08:43:45 -0400
In-Reply-To: <CAN+gG=FAFX-N-3FpAmgkE+im4oT9h657Rk9h3=-17sCBwVx35A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com
Cc: jeffbrown@android.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, Jeff Brown <jeffbrown@google.com>


Le 25 juil. 2011 =E0 11:29, benjamin.tissoires@gmail.com a =E9crit :

>=20
> I checked (with some greps) the reports we have, and it seems that al=
l
> the device we know provide this application. So it should be safe, bu=
t
> I'm not able to test it.
> St=E9phane, if you have the time to test it on our lab's devices that
> would be great.

We checked with Stantum and Lumio panels, it works fine. Added to Benja=
min's check in our database of report descriptors, it gives fairly good=
 confidence that the change is innocuous (and actually beneficial).

St.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
