From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell
 Latitudes
Date: Sun, 1 Feb 2015 21:34:08 -0800
Message-ID: <20150202053408.GA20333@dtor-ws>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
 <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
 <201501171126.50081@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33423 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbBBFeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 00:34:13 -0500
Received: by mail-ie0-f172.google.com with SMTP id at20so15353035iec.3
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2015 21:34:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201501171126.50081@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Sat, Jan 17, 2015 at 11:26:50AM +0100, Pali Roh=E1r wrote:
> On Wednesday 14 January 2015 23:55:53 Dmitry Torokhov wrote:
> > On some Dell Latitudes we fail to identify presence of
> > trackstick unless we reset the device. The issue is quite
> > benign as we do perform reset in alps_init(), so the
> > trackstick ends up working, but mouse name reported to
> > userspace is not accurate.
> >=20
> > In order to fix the issue while avoiding the additional
> > lengthy reset we move the resrt to alps_detect() and keep the
> > discovered state to be used later in alps_init().
> >=20
> > Reported-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> This patch is not enough. ALPS_DUALPOINT flag can be removed also=20
> in function alps_hw_init_rushmore_v3() which is called from=20
> alps_init() but not from alps_detect(). So this patch does not=20
> have to set correct name in alps_detect() based on ALPS_DUALPOINT=20
> flag. My original patch set name in alps_init() after hw_init()=20
> which handled also this problem...

Hmm, I think if we are still seeing these after somewhat recent additio=
n
of full reset in detect procedure we need to fix our detection instead
of tweaking capabilities after initialization phase fails. So I will
just remove that bit from alps_hw_init_rushmore_v3(). FWIW I did a quic=
k
search on Google and do not seem to find dmesgs with message
"trackstick E7 report failed".

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
