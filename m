From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Mon, 31 Aug 2009 02:47:41 -0300
Message-ID: <20090831024741.69fe587b@pedra.chehab.org>
References: <20090827045710.2d8a7010@pedra.chehab.org>
	<20090827183636.GG26702@sci.fi>
	<20090827185853.0aa2de76@pedra.chehab.org>
	<829197380908271506i251b47caoe8c08d483e78e938@mail.gmail.com>
	<20090828004628.06f34d12@pedra.chehab.org>
	<20090828041459.67c1499a@pedra.chehab.org>
	<alpine.LRH.1.10.0908281150120.10085@pub6.ifh.de>
	<20090828093042.3cf3c770@pedra.chehab.org>
	<20090829154528.74cd98da@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20090829154528.74cd98da@pedra.chehab.org>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Patrick Boettcher <pboettcher@kernellabs.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Devin Heitmueller <dheitmueller@kernellabs.com>, Ville =?ISO-8859-1?B?U3lyauRs5A==?= <syrjala@sci.fi>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Em Sat, 29 Aug 2009 15:45:28 -0300
Mauro Carvalho Chehab <mchehab@infradead.org> escreveu:

> Ok, I've did several changes on both V4L and dvb-usb IR implementations. They
> scancode tables are now implemented at the same way, at:
> 	http://linuxtv.org/hg/~mchehab/IR

Ok, I've also updated the V4L2 API spec with the default keyboard mapping on
the above URL. If nobody complains, I'll update our development tree with the
above changes likely today (Aug, 31) night, and prepare the changesets to be
added at linux-next.

Cheers,
Mauro
