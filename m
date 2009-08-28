From: Andy Walls <awalls@radix.net>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Fri, 28 Aug 2009 07:41:22 -0400
Message-ID: <1251459682.3187.38.camel@palomino.walls.org>
References: <20090827045710.2d8a7010@pedra.chehab.org>
	 <20090827183636.GG26702@sci.fi> <20090827185853.0aa2de76@pedra.chehab.org>
	 <829197380908271506i251b47caoe8c08d483e78e938@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <829197380908271506i251b47caoe8c08d483e78e938@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2009-08-27 at 18:06 -0400, Devin Heitmueller wrote:
> On Thu, Aug 27, 2009 at 5:58 PM, Mauro Carvalho
> Chehab<mchehab@infradead.org> wrote:
> > Em Thu, 27 Aug 2009 21:36:36 +0300
> > Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi> escreveu:

> Since we're on the topic of IR support, there are probably a couple o=
f
> other things we may want to be thinking about if we plan on
> refactoring the API at all:
>=20
> 1.  The fact that for RC5 remote controls, the tables in ir-keymaps.c
> only have the second byte.  In theory, they should have both bytes
> since the vendor byte helps prevents receiving spurious commands from
> unrelated remote controls.  We should include the ability to "ignore
> the vendor byte" so we can continue to support all the remotes
> currently in the ir-keymaps.c where we don't know what the vendor byt=
e
> should contain.

Since I uncovered this in my research, I thought I'd share...

RC-6A has a third (or thrid and fouth) byte:

http://www.picbasic.nl/frameload_uk.htm?http://www.picbasic.nl/info_rc6=
_uk.htm

for the "Customer Identifier".

It appears that the mode bits in the header determine if RC-6 (mode 0)
or RC-6A is in use.  The position of the mode bits in the header are
documented here:

http://www.sbprojects.com/knowledge/ir/rc6.htm

I'm guesing some MCE remotes use RC-6A.  When I get CX23888 IR support
to the point of actually working, I'll check both of my MCE remotes.

Regards,
Andy


--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
