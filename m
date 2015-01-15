From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Thu, 15 Jan 2015 10:18:20 -0800
Message-ID: <20150115181820.GF33214@dtor-ws>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
 <201501151149.32065@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:50959 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbbAOSSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 13:18:24 -0500
Received: by mail-ig0-f181.google.com with SMTP id r2so14121386igi.2
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 10:18:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201501151149.32065@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

On Thu, Jan 15, 2015 at 11:49:32AM +0100, Pali Roh=E1r wrote:
> On Wednesday 14 January 2015 23:55:48 Dmitry Torokhov wrote:
> > Hi Pali,
> >=20
> > This series try to address the issue you brought regarding
> > trackstick initialization on Dell Latitudes in a different
> > way than the patches you proposed. Basically in this series
> > we move resetting and all detection in alps_detect() and make
> > sure we keep the state so alps_init() can reuse it and not
> > perform the detection all over again. Doing this allows us to
> > set up device characteristics (name, version, etc) properly
> > from the get go while still performing reset only once.
> >=20
> > This is untested as I do not have any ALPS devices anymore so
> > I'd appreciate you giving it a spin.
> >=20
> > Thanks!
>=20
> Hi Dmitry,
>=20
> on top of which branch/repository should I apply your patches?

Should be applicable to my 'next' branch (which I just upreved to
3.19-rc4).

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
