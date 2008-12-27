From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hid-dummy in 2.6.28_rc8
Date: Sat, 27 Dec 2008 23:41:37 +0100
Message-ID: <4956AF21.9070807@gmail.com>
References: <495293BC.9000104@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:8961 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbYL0Wln (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Dec 2008 17:41:43 -0500
In-Reply-To: <495293BC.9000104@pardus.org.tr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 12/24/2008 08:55 PM, Ozan =C3=87a=C4=9Flayan wrote:
> Hi,
>=20
> Whenever I boot into 2.6.28_rc8, the following line is printed(probab=
ly
> by modprobe triggered by udev) to the console:
>=20
> FATAL: Error inserting hid_dummy
> (/lib/modules/2.6.28_rc8-114/kernel/drivers/hid/hid-dummy.ko):
> Input/output error
>=20
> No signs of error on dmesg output? Any ideas that can help or debug t=
he
> issue?

Hi, the error is non-fatal in this case, in addition, it's intentional.=
 The
module is there only for dependency loading and kills itself by returni=
ng the
error from load function to not eat resources any further after it does=
 its job.
The module will be removed completely in next few releases.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
