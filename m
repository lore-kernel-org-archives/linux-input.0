From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: 2.6.28 thinks that my PS/2 mouse is a touchpad
Date: Tue, 30 Dec 2008 15:29:03 +0100
Message-ID: <20081230142903.GA3449@adopmeer.homeip.net>
References: <gj4r8h$okm$1@ger.gmane.org> <20081229185619.GA18394@adopmeer.homeip.net> <4959B9B7.2050800@gmail.com> <200812300115.02408.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753801AbYL3O3V@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200812300115.02408.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 30, 2008 at 01:15:01AM -0800, Dmitry Torokhov wrote:
> On Monday 29 December 2008 22:03:35 Alexander E. Patrakov wrote:
> >
> > This is still slightly wrong. The mouse does work, but is misnamed in
> > the dmesg output and in /proc/bus/input/devices:
> >
> > psmouse serio1: ID: 10 00 64<6>elantech.c: Elantech version query result
> > 0x00, 0x01, 0x64.
> > elantech.c: Probably not a real Elantech touchpad. Aborting.
> > input: ImExPS/2 Elantech Touchpad as /class/input/input8
> 
> Yeah, elantech_init() is too late, we need to do something in
> elantech_detect()... 

Well, we could also move that Elantech version query and test for sane
values into elantech_detect().  However, because we have no private data
structure at that time it would mean we have to do the same query again in
elantech_init() to store fw_version_maj and fw_version_min.

> Maybe we need to pull part of Logitech check (number of buttons for
> example) from logips2pp.c.

I think the solution above is simpler although maybe not as pretty... :)


Arjan
