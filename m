From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [HP6XX/FIX/PATCH] - Fix bad default keymap in HP Jornada 6xx keyboard driver
Date: Sun, 16 Dec 2007 21:51:30 +0900
Message-ID: <20071216125130.GB12769@linux-sh.org>
References: <20071212192207.196f18cc.Kristoffer.ericson@gmail.com> <20071212184558.GA16129@linux-sh.org> <20071212195452.d854ea6f.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933582AbXLPMvz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071212195452.d854ea6f.Kristoffer.ericson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Dmitry <dmitry.torokhov@gmail.com>, linux-input-list <linux-input@atrey.karlin.mff.cuni.cz>, linux-main <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 12, 2007 at 07:54:52PM +0100, Kristoffer Ericson wrote:
> On Thu, 13 Dec 2007 03:45:58 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, Dec 12, 2007 at 07:22:07PM +0100, Kristoffer Ericson wrote:
> > > * This patch fixes the HP Jornada 6xx keyboard default keymap which
> > > had some bad keymap values. This resulted in wrong key being
> > > returned when pressed (example : key y returned 'r').
> > > 
> > You do realize that the default keymap was written for the Japanese units
> > and the Japanese keyboards, right? From the looks of it, you are just
> > trying to swap one functional set for another. I can assure you that this
> > keymap worked fine on the Japanese units, so calling it a bug is a bit
> > misleading.
> 
> Mostly true yes. However a few errors entered simply due to me copying
> the keymap poorly in the initial keymap. So it does infact have 'bug'
> keys that wouldn't work properly on neither japanese / european / US
> jornadas. And whatever functional set, this patch fixes those bugs.
> 
Ah, ok, so it's a problem with the new driver, rather than something
that's always been broken. No objections then, thanks for clearing that
up.
