From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Sat, 10 Apr 2010 08:16:00 -0400
Message-ID: <y2t9e4733911004100516wf10a8c94lfb83e6503776222a@mail.gmail.com>
References: <20100408113910.GA17104@hardeman.nu>
	 <1270812351.3764.66.camel@palomino.walls.org>
	 <s2o9e4733911004090531we8ff39b4r570e32fdafa04204@mail.gmail.com>
	 <4BBF3309.6020909@infradead.org> <20100410064801.GA2667@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100410064801.GA2667@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Andy Walls <awalls@md.metrocast.net>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 10, 2010 at 2:48 AM, David H=E4rdeman <david@hardeman.nu> w=
rote:
> On Fri, Apr 09, 2010 at 11:00:41AM -0300, Mauro Carvalho Chehab wrote=
:
>> struct {
>> =A0 =A0 =A0 unsigned mark : 1;
>> =A0 =A0 =A0 unsigned duration :31;
>> }
>>
>> There's no memory spend at all: it will use just one unsigned int an=
d it is
>> clearly indicated what's mark and what's duration.
>
> If all three of you agree on this approach, I'll write a patch to con=
vert
> ir-core to use it instead.

=46ine with me.

>
> --
> David H=E4rdeman
>



--=20
Jon Smirl
jonsmirl@gmail.com
