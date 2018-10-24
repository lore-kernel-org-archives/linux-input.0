From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: 2nd Fan quirk for Thinkpad P50 causes spurios
 touchpad/trackpoint events on ThinkPad L570
Date: Tue, 23 Oct 2018 21:47:38 -0300
Message-ID: <20181024004738.kbafambtfwau3uzw@khazad-dum.debian.net>
References: <eee05e84-42ed-a6ad-65c6-f5b2fe7cdd27@ristioja.ee>
 <36111ed4-621c-47a8-bc6a-66cf756a0ac6@ristioja.ee>
 <CAKdAkRTbQ+-+h8SMGf9Khc4+wE+P3_UCbYR0DDi1MoBwfSOWZQ@mail.gmail.com>
 <20181023035007.iy5vy2z3vuto2d6s@khazad-dum.debian.net>
 <CAJ2ouawfddrf8K22auR4OaJkO_n5f-rme=+XrbQYNo0eJfCtQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ2ouawfddrf8K22auR4OaJkO_n5f-rme=+XrbQYNo0eJfCtQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: agk-mA9ux5SlULTR7s880joybQ@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jaak-89mTbI93R4uuvFJfX82//w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Oct 2018, Jouke Witteveen wrote:
> > Apparently it has to be fixed properly, because if I understood the
> > issue correctly, every two-character quirk will trigger on *any*
> > three-character model that starts with those two characters.
> 
> This should be (and hopefully is) incorrect.
> In the tpacpi_check_quirks function, equality between the quirk bios
> and the actual model bios is tested. For two-character models there
> are three nonzero bytes, for two character models there are only two.

Hmm, good.  Need to check the parser that is feeding it, though.

One actually has to parse a DMI string like aaETxxWW (old models) and
aaaET????  (need to actually verify how the ending goes on three-char
models).  This for BIOS.  For EC, it used to be HT instead of ET for
H8S-based embedded controllers, maybe it changed for the new ARC-based
embedded controllers.

> That said, I do wonder why the fan quirks redefine all matching macros
> (TPACPI_FAN_Q*) and don't use the generic ones (TPACPI_Q*). This looks
> like an easy thing to clean up.

They used to have some minor differences.  A cleanup patch is likely
fine, as long as it is tested.

-- 
  Henrique Holschuh
