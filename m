From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Driver for Primax keyboards violating USB HID spec
Date: Fri, 14 Oct 2011 11:30:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110141127240.14768@pobox.suse.cz>
References: <1318548517-5289-1-git-send-email-tlambert@chromium.org> <alpine.LNX.2.00.1110140134200.14768@pobox.suse.cz> <CAA_E9NHi4mS+J5VrxS915S3TD-157D=hMG7b-PMT2c1RYvnwVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50511 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab1JNJaV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 05:30:21 -0400
In-Reply-To: <CAA_E9NHi4mS+J5VrxS915S3TD-157D=hMG7b-PMT2c1RYvnwVQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Lambert <tlambert@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011, Terry Lambert wrote:

> Hi Jiri; thanks for looking so promptly!
>=20
> The routine right now just caches the hi->input for later look up
> during the raw input report, which I suppose could be done inline on
> each report with a couple function calls.

Well yes, but even in px_raw_event() the px_device *px is only=20
initialized, but never used. So I'd just remove the whole px_device thi=
ng=20
altogether, I don't think it's needed.

> I don't have one of the folding keyboards people are complaining abou=
t
> not being able to use for Android tablets on hand, or the unhappy Del=
l
> Inspiron laptop, both of which use the controller  =A0That's to expla=
in
> why the remapping code and the product ID for them are missing from
> this patch.

I see.

I'd like to ask you though to only submit patches containing code that =
is=20
actually used. Whenever the remapping part is needed for some other=20
keyboard, we'll just add it at the very time it's needed.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
