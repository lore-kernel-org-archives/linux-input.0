From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] leds-clevo-mail: hw accelerated LED blink extension
Date: Tue, 17 Jul 2007 09:04:34 -0400
Message-ID: <d120d5000707170604q2e3c0d36g9bea02f4ed3d3050@mail.gmail.com>
References: <469C977A.8000908@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762779AbXGQNEq@vger.kernel.org>
In-Reply-To: <469C977A.8000908@freemail.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

On 7/17/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
>
> +Hardware accelerated blink of LEDs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Some LEDs can be programmed to blink without any CPU interaction. To
> +support this feature, a LED driver can optionally implement the
> +blink_set() function (see <linux/leds.h>). If implemeted, the
> +ledtrig-timer tries to use it. The blink_set() function should retur=
n
> +1 if the blink setting is supported, or 0 otherwise, which means tha=
t
> +the LED will be turned on and off from software.

Normally object methods in kernel return 0 on success and error code
(such as -EINVAL for unsupported parameters) on error.

--=20
Dmitry
