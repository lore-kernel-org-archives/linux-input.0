From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys
	to input.h
Date: Tue, 29 May 2007 10:05:28 -0300
Message-ID: <20070529130528.GB12935@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	<200705262340.28219.dtor@insightbb.com>
	<20070527121513.GC19562@khazad-dum.debian.net>
	<200705282316.32173.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200705282316.32173.dtor-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Dmitry Torokhov <dtor-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Cc: linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 28 May 2007, Dmitry Torokhov wrote:
> On Sunday 27 May 2007 08:15, Henrique de Moraes Holschuh wrote:
> > On Sat, 26 May 2007, Dmitry Torokhov wrote:
> > > I am unconvinced that we need new keycodes. Isn't there a better default
> > > keycodes for these keys? You mentioned that fn+f5 controls radio on many
> > > thinkpads, why don't you use KEY_WLAN in your keymap?
> > 
> > No can do the KEY-WLAN thing, sorry.  I *don't* have a way to know, unless I
> > add a model-specific map table to the kernel, and I have been told by
> > numerous people to don't even try, unless it is for quirks, etc.
> 
> Why not? It thinkpad-acpi is a box-specific driver and you could try to
> setup proper keymap depending on models. We do that in wistron_btns and
> it doers not even need alot of memory (keymaps and dmi data is marked
> __initdata and is discarded).

Well, I will try, let's see if ACPI upstream will take it after I tell them
it was decided to be the best approach by the input layer people.  Yes, it
can be __initdata, so it should not cause any drawbacks.

But I will still need to add keys, and I still think that a bunch of 32 or
so HOSTSPECIFIC keys is a very very good idea to have, *even* if I add some
model specific knowledge and already remap a few of the hot key keyboard to
less generic events where possible.

> > Really, what are we to do with that input.h scancode map?  It *IS* supposed
> > to be absolute, i.e. one is not supposed to reuse keys in there if the
> > functionality *or* the generic description is not an exact match.
> 
> Are there any markings on those keys?

Only a few of them.  And the ones I wanted to add are *not* marked in most
models :-)

The markings change a bit from model to model, and we have a *very*
incomplete list of those...

> > This is 
> > extremely clear, and it makes complete sense from the point of view of
> > userland: HAL and others can properly assign functions to all scan codes and
> > it will be always correct.
> 
> Are you arguing for KEY_THINKPAD_FN_F1, etc? And it being different from
> KEY_ACER_FN_F1? I don't think it is a good idea... 

No.  I am arguing for

#define KEY_HOSTSPECIFIC_01  0x1d0
...
#define KEY_HOSTSPECIFIC_32  0x1ef

And using that in place of KEY_FN, KEY_FN_F1... etc.  Userspace will be
responsible for mapping THESE keys (and only these keys) to something that
makes sense.  But I am arguing for this if, and only if, we cannot extend
KEY_MAX.

Alternatively, if you let me add keys, I will need a few of them, and they
are also generic (not necessarily thinkpad-specific).  Stuff like:

KEY_FN_BACKSPACE,
KEY_VENDORHOMEPAGE,
etc.

This will nearly exaust, or it might even exaust the current KEY_MAX space,
and KEY_MAX will need to get bumped one extra bit.  I still think *this* is
the best solution, but I offered the KEY_HOSTSPECIFIC one because I
perceived a big resistence to adding new keys and increasing KEY_MAX in the
past...

> > But then, it is expensive memory-wise, so it is near the current KEY_MAX,
> > and people are very, very relutant to add another bit to it.
> 
> Not really expensive. Right now keys cost 128 bytes per input device,
> absolute axis data cost much more. If we really need it we could increase
> KEY_MAX.

Well, I would *really* appreciate if I can add the thinkpad hot keys to the
key map, then.  It is best for userspace, and it keeps the scan code
generation style we have been using for a long time, where you assign keys
every time there is not a match that serves *exactly*.

I know I am in the unconfortable position of being the poor schmuck that had
to ask for it when the perceived cost is bigger (i.e. I will need, maybe one
or two keys in the 0x200 range, if any at all), but someone had to be it.

> > This is definately a ridiculous and aggravating situation, that deserves a
> > proper fix.  If increasing the scancode table cannot be done (why?), it is
> > time to stop denying reality, and remove everything after KEY_FN (0x1d0),
> > and instead give us a block of KEY_HOSTSPECIFIC_* scancodes, from 0x1d0 to
> > at least 0x1ef.
> > 
> > Given the way that scancode table is being used, it is one way or the other.
> > Either increase it to KEY_MAX=0x3ff, or do exactly what UNICODE did, give us
> > a decently sized block of host-specific scancodes, and shunt the problem to
> > userspace to clean up after.
> 
> In this case I better do nothing and leave everything as KEY_RESERVED and
> let userspace load proper keymap for the device.

That is a really, really undesireable solution.  It is worse than
KEY_HOSTSPECIFIC, and much worse than increasing KEY_MAX.  Can't we go with
one of the other two?  Either one would give a sound technical solution to
the issue.

Papering over the problem won't make it go away, after all.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
