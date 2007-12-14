From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [BUG] Kernel Bugs Weekly (maybe bi-weekly)
Date: Fri, 14 Dec 2007 08:15:25 -0500
Message-ID: <1197638126.3154.65.camel@localhost.localdomain>
References: <32209efe0712132057x247219e0m602f24d1e3a2c20b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <32209efe0712132057x247219e0m602f24d1e3a2c20b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Natalie Protasevich <protasnb@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-input@atrey.karlin.mff.cuni.cz, linux-dvb@linuxtv.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2007-12-13 at 20:57 -0800, Natalie Protasevich wrote:
> snd_hda_intel doesn't mute front speakers when headset is plugged in
> http://bugzilla.kernel.org/show_bug.cgi?id=9338
> Kernel: 2.6.23+
> Vaio VGN-FZ19VN

I'm not sure this one's a bug ... but it would depend on the chip
specifics.  The Intel HDA is designed to have separately controllable
line out and external features.  I like this and consider it to be a
nice feature.  However, it's not impossible that the Vaio is wired up
differently from my fujitsu, which also has a slightly different rev of
the controller:

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

However (modulo severe problems with pulseaudio) it works just fine for
me (separate sliders for line out and speakers) with 2.6.23.8 on a
Fujitsu 7120P LifeBook.

James


