From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH] Make PNP IDs all uppercase
Date: Wed, 21 Jan 2009 09:18:30 +0100
Message-ID: <20090121091830.225646d9@i1501.lan.towertech.it>
References: <49733678.40006@gmx.de>
	<200901201742.10155.bjorn.helgaas@hp.com>
	<4976D517.2070406@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4976D517.2070406@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Philipp Kohlbecher <xt28@gmx.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Hans Verkuil <hverkuil@xs4all.nl>, "David S. Miller" <davem@davemloft.net>, Jaroslav Kysela <perex@perex.cz>, Adam Belay <abelay@mit.edu>, Len Brown <lenb@kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 21 Jan 2009 08:56:07 +0100
Philipp Kohlbecher <xt28@gmx.de> wrote:

> switch and could not access the RTC anymore. My RTC is handled by 
> rtc-cmos, which is compiled as a module. However, udev did not load this 
> module, as the device's modalias "acpi:PNP0B00:" did not match any of 

 your main RTC should be compiled in, or you will have problems
 with fsck.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

