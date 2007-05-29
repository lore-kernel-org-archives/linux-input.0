From: Dmitry Torokhov <dtor-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys
	to input.h
Date: Mon, 28 May 2007 23:16:30 -0400
Message-ID: <200705282316.32173.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	<200705262340.28219.dtor@insightbb.com>
	<20070527121513.GC19562@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070527121513.GC19562-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sunday 27 May 2007 08:15, Henrique de Moraes Holschuh wrote:
> On Sat, 26 May 2007, Dmitry Torokhov wrote:
> > On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> > > Add hotkeys available in almost all ThinkPads manufactured in the last five
> > > years (more than one million machines given the ammount of batteries
> > > recalled) to input.h, and make thinkpad-acpi use those instead of issuing
> > > KEY_UNKNOWN.
> > > 
> > > KEY_FN_PAGEDOWN is not ever reported by the ThinkPad firmware due to random
> > > bogon-induced stupidity at IBM some years ago, but it is provided because
> > > it doesn't make sense to define KEY_FN_PAGEUP and not define
> > > KEY_FN_PAGEDOWN at the same time.
> > > 
> > 
> > I am unconvinced that we need new keycodes. Isn't there a better default
> > keycodes for these keys? You mentioned that fn+f5 controls radio on many
> > thinkpads, why don't you use KEY_WLAN in your keymap?
> 
> No can do the KEY-WLAN thing, sorry.  I *don't* have a way to know, unless I
> add a model-specific map table to the kernel, and I have been told by
> numerous people to don't even try, unless it is for quirks, etc.
> 

Why not? It thinkpad-acpi is a box-specific driver and you could try to
setup proper keymap depending on models. We do that in wistron_btns and
it doers not even need alot of memory (keymaps and dmi data is marked
__initdata and is discarded).

> Really, what are we to do with that input.h scancode map?  It *IS* supposed
> to be absolute, i.e. one is not supposed to reuse keys in there if the
> functionality *or* the generic description is not an exact match.

Are there any markings on those keys?

> This is 
> extremely clear, and it makes complete sense from the point of view of
> userland: HAL and others can properly assign functions to all scan codes and
> it will be always correct.
>

Are you arguing for KEY_THINKPAD_FN_F1, etc? And it being different from
KEY_ACER_FN_F1? I don't think it is a good idea... 
 
> But then, it is expensive memory-wise, so it is near the current KEY_MAX,
> and people are very, very relutant to add another bit to it.
>

Not really expensive. Right now keys cost 128 bytes per input device,
absolute axis data cost much more. If we really need it we could increase
KEY_MAX.
 
> This is definately a ridiculous and aggravating situation, that deserves a
> proper fix.  If increasing the scancode table cannot be done (why?), it is
> time to stop denying reality, and remove everything after KEY_FN (0x1d0),
> and instead give us a block of KEY_HOSTSPECIFIC_* scancodes, from 0x1d0 to
> at least 0x1ef.
> 
> Given the way that scancode table is being used, it is one way or the other.
> Either increase it to KEY_MAX=0x3ff, or do exactly what UNICODE did, give us
> a decently sized block of host-specific scancodes, and shunt the problem to
> userspace to clean up after.
>

In this case I better do nothing and leave everything as KEY_RESERVED and
let userspace load proper keymap for the device.  

-- 
Dmitry

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
