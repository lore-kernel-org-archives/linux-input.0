From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Anything against a new EV_SW SW_RADIO event ?
Date: Mon, 25 Jun 2007 06:05:00 -0300
Message-ID: <20070625090459.GA30237@khazad-dum.debian.net>
References: <20070624105514.GA8909@khazad-dum.debian.net>
	<200706250022.15244.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200706250022.15244.dtor-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
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
Cc: linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 25 Jun 2007, Dmitry Torokhov wrote:
> On Sunday 24 June 2007 06:55, Henrique de Moraes Holschuh wrote:
> > Could you ACK the attached patch?  I am about to send in code that would
> > benefit a damn great deal from it (thinkpad-acpi support for the
> > T60/X60/newer radio-kill slider switch)...  So I thought it would be best to
> > check with you first if I can have an EV_SW SW_RADIO...
> 
> Adding SW_RADIO would be fine. My only question is if SW_ARDIO is enough or
> if we would need SW_WIFI/SW_BLUETOOTH/SW_ETC down the road...

I will add an ACK from you to the EV_SW SW_RADIO patch, then.

As for a rabbit-breeding of radio switches, well, that should not happen on
ThinkPads, at least.  They might have other types of switches (on the
docks), but I don't see a risk of SW_WIFI/SW_BLUETOOTH ever happening
there... or in any other normal laptop, the regulations ask for a way to
kill *all* radios on airplanes and explosive atmosphere areas, and they're
the reason for the switches.

The thinkpad radio hot key (not the switch) may be bluetooth-only in
firmware, but it is supposed to be overriden by any O.S. with a driver, and
the "reference" usercase for it (IBM/Lenovo's ThinkVantage suite) offers to
switch on/off all radios or to apply a given radio profile, etc.  I.e. the
key is used as an application launch key.  Again, the trend is not for
separate radio-type switches or keys, there.

I'd say we should cross the multiple radio-types bridge if we ever happen
upon it, but not to waste much brain resources over it at this time.  And it
still looks like we'd need a generic radio switch anyway, that all radio
types are to obey...

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
