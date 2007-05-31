From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Making KEY_UNKNOWN really useful to userland
Date: Thu, 31 May 2007 11:37:05 +0100
Message-ID: <1180607825.2693.17.camel@localhost.localdomain>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	<200705262340.28219.dtor@insightbb.com>
	<20070527121513.GC19562@khazad-dum.debian.net>
	<200705282316.32173.dtor@insightbb.com>
	<20070529130528.GB12935@khazad-dum.debian.net>
	<d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
	<20070530152444.GD17530@khazad-dum.debian.net>
	<d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
	<20070530172420.GA6883@khazad-dum.debian.net>
	<d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
	<20070531005305.GC6883@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070531005305.GC6883-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
Cc: linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2007-05-30 at 21:53 -0300, Henrique de Moraes Holschuh wrote:
> Maybe we can add that requirement and driver changes (if any, for all
> I know most drivers might already be generating such events) for
> 2.6.23?  I bet Richard would like that one a lot.  Richard?

To be honest, I've got lost in all the discussion about hotkeys. What is
the plan for a typical acpi driver?

i.e. what do you want a driver to emit given two scenarios:

* A acpi event that is always the same on all models?
   KEY_BRIGHTNESSUP?

* an acpi event that is different on every laptop model?
   KEY_PROG1? KEY_UNKNOWN?

Tell me what do to, and I'll resync my trees and resubmit patches.

Thanks.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
