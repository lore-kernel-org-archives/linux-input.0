From: Ilya Petrov <ilya.muromec@gmail.com>
Subject: Re: [PATCH] PCAP misc input driver (for 2.6.32)
Date: Mon, 29 Jun 2009 19:27:24 +0300
Message-ID: <800a98740906290927q5469f17fpcd74295e7ce40fb0@mail.gmail.com>
References: <1246122592.3727.20.camel@brutus>
	<20090629094658.GE11855@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <openezx-devel-bounces@lists.openezx.org>
In-Reply-To: <20090629094658.GE11855@sirena.org.uk>
List-Unsubscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: openezx-devel <openezx-devel@lists.openezx.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, inux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: linux-input@vger.kernel.org

2009/6/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> Depending on the power management capabilities of the CODEC it may be
> better to support at laest the headphone insert/removal via the audio
> driver as a jack to allow automatic management of the power for the
> relevant paths within the CODEC.

we need to control this manually from userspace - for example, even with
headphone plugged in ringtone should be played via speaker.



-- 
 wbr, Ilya
 ICQ: none, Jabber: ilya.muromec@jabber.ru
