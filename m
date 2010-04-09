From: Andy Walls <awalls@radix.net>
Subject: Re: [PATCH] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Fri, 09 Apr 2010 17:36:38 -0400
Message-ID: <1270848998.3038.47.camel@palomino.walls.org>
References: <20100408161000.GA23119@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408161000.GA23119@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2010-04-08 at 18:10 +0200, David H=C3=A4rdeman wrote:

> With this patch:
>=20
> s64 int's are used to represent pulse/space durations in ns

If performing divides on 64 bit numbers, please check to make sure your
code compiles, links, and loads on a 32-bit system.

We've had problems in the past in where gcc will build the module to
reference __udivdi3 under 32-bit kernels; but that symbol is not in the
kernel.

Search for 'do_div' in:

	linux/drivers/media/video/cx18/cx18-av-core.c

for a simple example divide that works on both 64 and 32 bit machines.

Regards,
Andy
