From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 2nd Fan quirk for Thinkpad P50 causes spurios
 touchpad/trackpoint events on ThinkPad L570
Date: Mon, 15 Oct 2018 17:11:54 -0700
Message-ID: <CAKdAkRTbQ+-+h8SMGf9Khc4+wE+P3_UCbYR0DDi1MoBwfSOWZQ@mail.gmail.com>
References: <eee05e84-42ed-a6ad-65c6-f5b2fe7cdd27@ristioja.ee>
 <36111ed4-621c-47a8-bc6a-66cf756a0ac6@ristioja.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <36111ed4-621c-47a8-bc6a-66cf756a0ac6-89mTbI93R4uuvFJfX82//w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: jaak-89mTbI93R4uuvFJfX82//w@public.gmane.org
Cc: agk-mA9ux5SlULTR7s880joybQ@public.gmane.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-devel <ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 13, 2018 at 6:32 AM Jaak Ristioja <jaak-89mTbI93R4uuvFJfX82//w@public.gmane.org> wrote:
>
> On 27.08.2018 19:22, Jaak Ristioja wrote:
> > Upgrading Linux from 4.16 to 4.17, a ThinkPad L570 started receiving
> > spurious input events, mostly right mouse button click events, but also
> > cursor jumps.
> >
> > I have not attempted to understand whether these events come from the
> > trackpoint or touchpad or some other driver, but I managed to bisect
> > this issue to commit a986c75a7df0 titled "platform/x86: thinkpad_acpi:
> > Add 2nd Fan Support for Thinkpad P50" by Alexander Kappner.
> >
> > Apparently the quirk mitigation is applied when the BIOS version begins
> > with N1. The BIOS version on the L570 in question is N1XET57W (1.35 )
> > which is probably why this commit causes the described problems on the
> > ThinkPad L570. How exactly? - I don't know.
> >
> > The issue did not reproduce when running some stable 4.17 and 4.18
> > kernels with commit a986c75a7df0 reverted.
> >
> > Please fix this for future kernels. Thanks! :)
>
> Ping. Do you need any additional information?

Sounds like we need tighter check for the quirk, maybe based on
DMI/Board name? Can we revert the offending commit for now?

Thanks.

-- 
Dmitry
