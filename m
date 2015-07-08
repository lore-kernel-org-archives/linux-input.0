From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: i2c-hid: Call device suspend callback before
 disabling irq
Date: Wed, 8 Jul 2015 12:44:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081243330.10183@pobox.suse.cz>
References: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com> <alpine.LNX.2.00.1507072248020.10183@pobox.suse.cz> <2307888.TWO9u1uPK9@xps13>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2307888.TWO9u1uPK9@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 8 Jul 2015, Gabriele Mazzotta wrote:

> i2c-hid takes care of requesting and handling IRQs for HID devices
> which in turns might expect them to be always active when working
> in normal conditions. Hence, disabling IRQs before calling the suspend
> callbacks can potentially cause problems since device drivers might
> try to perform operations needing them.
> 
> Fix this by disabling IRQs only after the suspend callbacks had been
> executed.

That's much nicer changelog, thanks. I've now applied the patch with this 
changelog to for-4.3/i2c-hid.

-- 
Jiri Kosina
SUSE Labs
