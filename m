From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.{28,30} Keyboard not working on oldish machine
Date: Tue, 16 Jun 2009 11:27:38 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906161126330.31685@twin.jikos.cz>
References: <20090613230842.GA18347@gallifrey> <4A349B67.1070603@zytor.com> <20090614122734.GA1499@gallifrey>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756758AbZFPJ1r@vger.kernel.org>
In-Reply-To: <20090614122734.GA1499@gallifrey>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 14 Jun 2009, Dr. David Alan Gilbert wrote:

> > > [    3.147416] PNP: No PS/2 controller found. Probing ports directly.
> > > [    3.174456] serio: i8042 KBD port at 0x60,0x64 irq 1
> > > [    3.174961] serio: i8042 AUX port at 0x60,0x64 irq 12
> > > [    3.186312] mice: PS/2 mouse device common for all mice
> > It does, correctly, identify the keyboard and mode port, so it's
> > somewhat odd that it doesn't get used...
> Indeed. The only other observation in the older kernel that works
> it detects the AUX port first.

Booting with 'i8042.debug' will spit some more output into dmesg, which 
might help us to see if i8042 is really properly initialized, or something 
strange is going on during initialization.

-- 
Jiri Kosina
SUSE Labs
