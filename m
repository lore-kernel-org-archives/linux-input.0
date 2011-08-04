From: bojan prtvar <prtvar.b@gmail.com>
Subject: Re: [PATCH 1/2] HID: kfree() NULL pointer cleanup
Date: Thu, 4 Aug 2011 23:16:49 +0200
Message-ID: <CAOmT4fThjOjBAcXmFqpqct3uzVOi3eQWknyD3TO+aC6CDXEnuQ@mail.gmail.com>
References: <1312490574-14804-1-git-send-email-prtvar.b@gmail.com>
	<Pine.LNX.4.64.1108042247000.1424@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47375 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab1HDVQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 17:16:50 -0400
In-Reply-To: <Pine.LNX.4.64.1108042247000.1424@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Aug 4, 2011 at 10:48 PM, Julia Lawall <julia@diku.dk> wrote:
> On Thu, 4 Aug 2011, Bojan Prtvar wrote:
>
> I would find it even nicer to just add a new lavel to skip over the k=
free
> in the case where pm is NULL. =C2=A0It is statically apparent in the =
source
> code.

Yes, it would be nicer. I'll send v2.

Regards,
Bojan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
