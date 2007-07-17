From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] leds-clevo-mail: export i8042_command()
Date: Tue, 17 Jul 2007 09:02:19 -0400
Message-ID: <d120d5000707170602g5311e048we02f1269de9769d5@mail.gmail.com>
References: <469C976B.3030206@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762811AbXGQNCc@vger.kernel.org>
In-Reply-To: <469C976B.3030206@freemail.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

On 7/17/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>
> Export the i8042_command() function which manages the mutual exclusio=
n
> with the help of the i8042_lock spinlock. This lets possible to use t=
he
> i8042 hardware safely from other part of the kernel, too.
>
> Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>

Please #include <linux/i8042.h> into i8042.c. Doing so saves from
nasty surprises later.

--=20
Dmitry
