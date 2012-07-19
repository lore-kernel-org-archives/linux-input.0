From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v2] Input: synaptics - use firmware data for Cr-48
Date: Thu, 19 Jul 2012 09:16:23 -0700
Message-ID: <500832D7.4040805@canonical.com>
References: <1342606923-9997-1-git-send-email-cywang@chromium.org> <5006D86C.7030208@canonical.com> <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35834 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2GSQQa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 12:16:30 -0400
In-Reply-To: <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?IkNodW5nLVlpaCBXYW5nICjnjovltIfmh78pIg==?= <cywang@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/18/2012 08:02 PM, Chung-Yih Wang (=E7=8E=8B=E5=B4=87=E6=87=BF) wr=
ote:
> Hi Chase,
>
>     Thanks for your great comments. You are right, it is impossible t=
o
> get  correct finger tracking if both fingers are moving. However, we
> think it still worth to have the firmware tracking of the fingers as
> they could perform well for most one-stationary-one-moving cases. Thi=
s
> will be good enough for the one-stationary-one-moving gestures we wan=
t
> to provide on Cr-48. And that's why we want to make the patch specifi=
c
> to Cr-48.

Can you provide more details on what you are attempting to accomplish?=20
The only thing you can't do easily with semi-mt is:

* Rotations (but the hardware can't do it anyway, so this is moot)
* Pinch directions at 45 degree angles (i.e. (pinch up and left, down=20
and right) or (pinch down and left, up and right))

You should be able to do everything else with semi-mt, such as pinch=20
horizontally vs pinch vertically, movement, etc.

The pinch directions at 45 degree angles could be possible with the=20
Cr-48 trackpad, but I would want to know that there's a real use case=20
for it before undertaking an effort to support it.

-- Chase
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
