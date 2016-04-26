From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 2/7] Input: cros_ec_keyb - Stop handling interrupts
 directly
Date: Tue, 26 Apr 2016 07:57:55 +0100
Message-ID: <20160426065755.GA19037@dell>
References: <1460464350-30414-1-git-send-email-tomeu.vizoso@collabora.com>
 <1460464350-30414-3-git-send-email-tomeu.vizoso@collabora.com>
 <20160425211735.GG26059@dtor-ws>
 <CAAObsKC3+Fw2QBKnur5ZYWw=Ys4yQaoEYdXV+cjNjGYyyO5McQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35177 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbcDZG54 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Apr 2016 02:57:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so101299048wme.0
        for <linux-input@vger.kernel.org>; Mon, 25 Apr 2016 23:57:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAObsKC3+Fw2QBKnur5ZYWw=Ys4yQaoEYdXV+cjNjGYyyO5McQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org

On Tue, 26 Apr 2016, Tomeu Vizoso wrote:

> On 25 April 2016 at 23:17, Dmitry Torokhov <dmitry.torokhov@gmail.com=
> wrote:
> > On Tue, Apr 12, 2016 at 02:32:25PM +0200, Tomeu Vizoso wrote:
> >> From: Vic Yang <victoryang@google.com>
> >>
> >> Because events other that keyboard ones will be handled by now on =
by
> >> other drivers, stop directly handling interrupts and instead liste=
n to
> >> the new notifier in the MFD driver.
> >>
> >
> > Hmm, where did Vic's sign-off go?
>=20
> Lee Jones asked to remove them in a previous version as he considers
> them superfluous. My understanding is that as I'm the first to submit
> them to mainline, the chain starts with me (I certify the b section o=
f
> http://developercertificate.org/).

Hmm... It seems what I said has been misconstrued a little.  You
*should* remove SoBs from people who were *only* part of the
submission path.  However, you should *not* remove SoBs from patch
*authors*.  Since Vic is the author (or at least one of them), their
SoB should remain.

Apologies if that was not clear.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
