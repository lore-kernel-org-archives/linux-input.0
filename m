From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/4] Input: misc: Add haptic driver on max77693
Date: Thu, 11 Sep 2014 23:43:37 -0700
Message-ID: <20140912064337.GB31165@core.coreip.homeip.net>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
 <1410440062-19963-3-git-send-email-jaewon02.kim@samsung.com>
 <20140911171002.GC13083@core.coreip.homeip.net>
 <54124EA1.8060507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36264 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbaILGnm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 02:43:42 -0400
Content-Disposition: inline
In-Reply-To: <54124EA1.8060507@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Sep 12, 2014 at 10:38:41AM +0900, Jaewon Kim wrote:
> Hello Dmity Torokhov.
>=20
> 2014=EB=85=84 09=EC=9B=94 12=EC=9D=BC 02:10=EC=97=90 Dmitry Torokhov =
=EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> >On Thu, Sep 11, 2014 at 09:54:20PM +0900, Jaewon Kim wrote:
> >>This patch add max77693-haptic device driver to support the haptic =
controller
> >>on MAX77693. The MAX77693 is a Multifunction device with PMIC, CHAR=
GER, LED,
> >>MUIC, HAPTIC and the patch is haptic device driver in the MAX77693.=
 This driver
> >>support external pwm and LRA(Linear Resonant Actuator) motor. User =
can control
> >>the haptic driver by using force feedback framework.
> >>
> >>Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> >>Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> >Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> >How do we want to merge this?
> >
> thanks for review.
>=20
> Please merge this input device patch only.
> Another patchs will be merged by lee jones.

Queued fro the next merge window (with some minor edits).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
