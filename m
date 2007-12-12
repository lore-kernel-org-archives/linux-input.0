From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP6XX/FIX/PATCH] - Fix bad default keymap in HP Jornada 6xx
 keyboard driver
Date: Wed, 12 Dec 2007 19:54:52 +0100
Message-ID: <20071212195452.d854ea6f.Kristoffer.ericson@gmail.com>
References: <20071212192207.196f18cc.Kristoffer.ericson@gmail.com>
	<20071212184558.GA16129@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759015AbXLLSz0@vger.kernel.org>
In-Reply-To: <20071212184558.GA16129@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Dmitry <dmitry.torokhov@gmail.com>, linux-input-list <linux-input@atrey.karlin.mff.cuni.cz>, linux-main <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 13 Dec 2007 03:45:58 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Wed, Dec 12, 2007 at 07:22:07PM +0100, Kristoffer Ericson wrote:
> > shortlog:
> > * This patch fixes the HP Jornada 6xx keyboard default keymap which had some bad keymap values. This resulted in wrong
> > key being returned when pressed (example : key y returned 'r').
> > * Also, while we are at it lets arrange the include files in alphabetical order.
> > 
> You do realize that the default keymap was written for the Japanese units
> and the Japanese keyboards, right? From the looks of it, you are just
> trying to swap one functional set for another. I can assure you that this
> keymap worked fine on the Japanese units, so calling it a bug is a bit
> misleading.

Mostly true yes. However a few errors entered simply due to me copying the keymap poorly in the initial keymap. So it does infact have 'bug' keys that wouldn't work properly on neither japanese / european / US jornadas. And whatever functional set, this patch fixes those
bugs.


