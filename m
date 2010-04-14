From: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Hotkeys generating input as well as ACPI events
Date: Wed, 14 Apr 2010 09:11:24 +0200
Message-ID: <s2x71cd59b01004140011jc2416c14x259627e278c6a162@mail.gmail.com>
References: <87vdbvvbp8.fsf@cybersource.com.au>
	<g2j71cd59b01004130512ydcecbbf9n5a8c5e271881d080@mail.gmail.com>
	<87633uq0oz.fsf@cybersource.com.au>
	<r2z71cd59b01004132314r6fdbbd63r3fba622d1c6f105f@mail.gmail.com>
	<87pr22o83t.fsf@cybersource.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87pr22o83t.fsf-3AaVwj9c10wJYc8buCWFOBCuuivNXqWP@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Trent W. Buck" <twb-3AaVwj9c10wJYc8buCWFOBCuuivNXqWP@public.gmane.org>
Cc: debian-eeepc-devel-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 8:34 AM, Trent W. Buck <twb-3AaVwj9c10wJYc8buCWFOBCuuivNXqWP@public.gmane.org> wro=
te:
> Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> writes:
>
>> All seems ok and I was able to reproduce the issue (only in screen),
>
> Hmm; I can also reproduce this as root on vt2, without screen. =A0It's
> more obvious if I run "cat -A" before typing; otherwise I only see a ~
> and hear a beep.
>
>> but I don't really know what's the best way to fix it.
>> Isn't there any way to "ignore" an input device in screen/fbcon ?
>
> I don't know. =A0I guess that would be disconnecting
>
> =A0 =A0/sys/devices/platform/eeepc/input/input8
> =A0 =A0i.e. SUBSYSTEM=3D=3D"input", NAME=3D=3D"Asus EeePC extra buttons"
>
> ...from fbcon. =A0Obviously I don't want to disable the ACPI events, nor
> the normal keyboard input. =A0I'll try to find an fbcon guru.
>
> I might be able to patch terminfo/termcap entries to discard those
> escape sequences, but it feels like a bodge.
>

If there is no way to ignore an input device in userspace, maybe the
right way to do it is to add a way to disable an input device using
some /sys/ file.

CC-ing linux-input, they probably have something to tell about that.

-- =

Corentin Chary
http://xf.iksaif.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
