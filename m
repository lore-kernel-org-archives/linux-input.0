From: Chuck Ebbert <cebbert.lkml@gmail.com>
Subject: Re: Disable input device
Date: Sat, 6 Dec 2014 10:28:55 -0500
Message-ID: <20141206102855.69b4b218@as>
References: <201411291824.03996@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57541 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbaLFP3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Dec 2014 10:29:01 -0500
In-Reply-To: <201411291824.03996@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Sat, 29 Nov 2014 18:24:03 +0100
Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:

> What do you think about adding new sysfs file "disable" (accept=20
> values 1 or 0) for every input device? With "1" it cause that=20
> kernel will drop all events from specific input device and if=20
> driver provide some function is can be called (e.g. for power=20
> management or disabling device at hardware level).
>=20

Yeah, I'd like to see this too. I am using xinput to disable the
notebook keyboard so the cats walking across it don't cause any
problems. It would be nice to have a better solution.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
