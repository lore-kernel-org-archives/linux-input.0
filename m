From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Thu, 28 Aug 2014 22:03:55 +0200
Message-ID: <53FF8B2B.3050506@ladisch.de>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>	<20140820051815.GA1109@core.coreip.homeip.net>	<s5hwqa3hetu.wl-tiwai@suse.de>	<20140820063130.GA11226@core.coreip.homeip.net>	<s5htx57hc89.wl-tiwai@suse.de>	<s5h4mx6rshs.wl-tiwai@suse.de>	<20140824050716.GA523@rhlx01.hs-esslingen.de> <s5hppfpt520.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hppfpt520.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Mohr <andi@lisas.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Takashi Iwai wrote:
> did anyone test the patch at all...?

Appears to work.  The ymfpci gameport seems to be somewhat unreliable:

 analog.c: 100 out of 17347 reads (0%) on pci0000:06:06.1/gameport0 failed
 analog.c: 122 out of 1111 reads (10%) on pci0000:06:07.0/gameport0 failed

There is still some dependence of the CPU speed on the loop counts
calculated by gameport_time(), but it's not very high; the following are
for 3200 and 800 MHz, 5 times each:

 gameport gameport7: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 651kHz
 gameport gameport8: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 651kHz
 gameport gameport9: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 651kHz
 gameport gameport10: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 651kHz
 gameport gameport11: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 651kHz
 gameport gameport12: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 612kHz
 gameport gameport13: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 612kHz
 gameport gameport14: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 612kHz
 gameport gameport15: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 611kHz
 gameport gameport16: EMU10K1 is pci0000:06:06.1/gameport0, io 0xe480, speed 612kHz


Regards,
Clemens
