From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] thinkpad-acpi: Improve hardware
	volume controls
Date: Thu, 12 May 2011 08:39:21 -0700
Message-ID: <20110512153921.GB8293@core.coreip.homeip.net>
References: <bf402af225e7005f052a8ccf92962efa48cbe703.1304979290.git.luto@mit.edu>
	<20110512134827.GA26159@srcf.ucam.org>
	<BANLkTimmrM4HMATSbsYzz6kh=e9hrfAZmg@mail.gmail.com>
	<20110512143912.GA28141@srcf.ucam.org>
	<BANLkTikX7mMu2me6+O1e-Ub=Cbzerd=J3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikX7mMu2me6+O1e-Ub=Cbzerd=J3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Lutomirski <luto-3s7WtUTddSA@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Andrew,

On Thu, May 12, 2011 at 10:50:54AM -0400, Andrew Lutomirski wrote:
> 
> I do, however, have a question for the input people.  Dmitry: Lenovo
> makes laptops which are kind enough to tell us that the volume changed
> by sending a keystroke over the atkbd-based keyboard.  (wtf!)  I've
> modified the thinkpad-acpi driver to register an input handler to
> catch those events coming from the keyboard and send them to ALSA
> where they belong.  But if there's a keyboard grab, it won't work.
> Would you accept a patch to the input layer to allow filters (or maybe
> just filters that specifically request it) to run even if there's a
> grab?

There is a filter on i8042 level that was introduced specifically for
cases when events not having any relation to the input are routed via
KBC interface. It looks like this is the one you want to use. See
include/linux/i8042.h::i8042_install_filter(). It allows for such events
to completely bypass input layer.

Hope this helps.

-- 
Dmitry

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
