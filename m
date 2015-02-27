From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 07:29:30 -0800
Message-ID: <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
References: <54F0507F.6030804@armadeus.com> <20150227153725.7404dea1@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43638 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbB0P3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 10:29:40 -0500
In-Reply-To: <20150227153725.7404dea1@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?ISO-8859-1?Q?S=E9bastien_SZYMANSKI?= <sebastien.szymanski@armadeus.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petazzoni=
@free-electrons.com> wrote:
>Dear S=C3=A9bastien SZYMANSKI,
>
>On Fri, 27 Feb 2015 12:09:51 +0100, S=C3=A9bastien SZYMANSKI wrote:
>
>>         error =3D input_register_device(sx8654->input);
>>         if (error)
>>                 return error;
>
>Where is your ->remove() function that unregisters the input device?

Everything seems to be allocated with devm so remove is not needed.


Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
