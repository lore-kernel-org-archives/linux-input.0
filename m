From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Tue, 8 May 2012 21:37:24 +0200
Message-ID: <20120508193724.GA24034@polaris.bitmath.org>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
 <4FA5889E.2030008@gmail.com>
 <4FA96AEF.4090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:42790 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab2EHTcZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 May 2012 15:32:25 -0400
Content-Disposition: inline
In-Reply-To: <4FA96AEF.4090106@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chase Douglas <chasedouglas@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, benjamin.tissoires@gmail.com, peter.hutterer@who-t.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 08, 2012 at 11:50:23AM -0700, H. Peter Anvin wrote:
> On 05/05/2012 01:07 PM, Chase Douglas wrote:
> >> =20
> >> +For devices capable of 360 degree orientation, the reported orien=
tation
> >> +should be twice the given range.
> >=20
> > I don't understand what this means. Can you elaborate?
> >=20
>=20
> A guess is that it means that the value is encoded as a single byte w=
ith
> a 2=B0 granuarity?

Both Benjamin and Chase had the same question, and the reply is here:

http://www.spinics.net/lists/linux-input/msg20736.html

Hopefully that helps.

Thanks for chipping in,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
