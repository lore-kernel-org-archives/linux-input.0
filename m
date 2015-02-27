From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 15:37:25 +0100
Message-ID: <20150227153725.7404dea1@free-electrons.com>
References: <54F0507F.6030804@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50966 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752538AbbB0Oh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 09:37:28 -0500
In-Reply-To: <54F0507F.6030804@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbg==?= SZYMANSKI <sebastien.szymanski@armadeus.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Dear S=C3=A9bastien SZYMANSKI,

On Fri, 27 Feb 2015 12:09:51 +0100, S=C3=A9bastien SZYMANSKI wrote:

>         error =3D input_register_device(sx8654->input);
>         if (error)
>                 return error;

Where is your ->remove() function that unregisters the input device?

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
