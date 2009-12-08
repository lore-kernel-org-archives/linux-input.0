From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: Tue, 08 Dec 2009 16:26:56 +0100
Message-ID: <m33a3ltrjz.fsf@intrepid.localdomain>
References: <BEJgSGGXqgB@lirc>
	<9e4733910912041628g5bedc9d2jbee3b0861aeb5511@mail.gmail.com>
	<1260070593.3236.6.camel@pc07.localdom.local>
	<20091206065512.GA14651@core.coreip.homeip.net>
	<4B1B99A5.2080903@redhat.com> <m3638k6lju.fsf@intrepid.localdomain>
	<9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>
	<m3skbn6dv1.fsf@intrepid.localdomain>
	<9e4733910912061323x22c618ccyf6edcee5b021cbe3@mail.gmail.com>
	<4B1D934E.7030103@redhat.com>
	<20091208042340.GC11147@core.coreip.homeip.net>
	<4B1E3F7D.9070806@redhat.com> <m34oo1va2y.fsf@intrepid.localdomain>
	<4B1E5EFA.4020801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4B1E5EFA.4020801@redhat.com> (Mauro Carvalho Chehab's message of
	"Tue, 08 Dec 2009 12:13:14 -0200")
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Mauro Carvalho Chehab <mchehab@redhat.com> writes:

> The enable/disable protocol decoder enable/disable interface is needed anyway,
> due to the needs for the hardware IR decoders

Why do they need it exactly?
The key tables say all they need I hope?
-- 
Krzysztof Halasa
