From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Thu, 26 Nov 2009 18:46:38 +0100
Message-ID: <m31vjlw54x.fsf@intrepid.localdomain>
References: <200910200956.33391.jarod@redhat.com>
	<200910200958.50574.jarod@redhat.com> <4B0A765F.7010204@redhat.com>
	<4B0A81BF.4090203@redhat.com> <m36391tjj3.fsf@intrepid.localdomain>
	<20091123173726.GE17813@core.coreip.homeip.net>
	<m3r5rpq818.fsf@intrepid.localdomain>
	<20091126052155.GD23244@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751976AbZKZRqg@vger.kernel.org>
In-Reply-To: <20091126052155.GD23244@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Wed, 25 Nov 2009 21:21:55 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org, Mario Limonciello <superm1@ubuntu.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Janne Grunau <j@jannau.net>, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> In what way the key interface is unsufficient for delivering button
> events?

At present: 128 different keys only (RC5: one group). One remote per
device only.

The protocol itself doesn't have the above limitations, but has others,
with are acceptable for key input.
-- 
Krzysztof Halasa
