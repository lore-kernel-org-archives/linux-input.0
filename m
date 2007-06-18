From: "Dmitry Torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: reseting an input device due to sleep/resume
	cycle
Date: Mon, 18 Jun 2007 09:48:37 -0400
Message-ID: <d120d5000706180648sac84927k2c11f070ede41122@mail.gmail.com>
References: <20070616210321.GA17379@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070616210321.GA17379-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
Cc: linux-input-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Henrique,

On 6/16/07, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org> wrote:
> Dmitry, input gurus,
>
> When a ThinkPad does an sleep cycle, the firmware explicitly kills all
> pending hotkey state.  That reminds me that I also need to do the same in
> thinkpad-acpi.
>
> How does one tell the input layer that it should clear its idea of the
> current state of all events in a input device?  I couldn't find any
> input_reset() function...
>
> Or is such a reset not needed?  The recent issue with ACPI and EV_SW SW_LID
> seems to indicate that in some cases these resets are indeed needed.  For
> EV_SW, it appears that I'd have to interate over all my switches and reset
> them.  But what about EV_KEY and the others?

We do need to refresh switch state upon resume because use may change
it while box is sleeping. With keys we shoudl just assume that they
are all released at the time box is waking up.

Now that I have input core converted to "struct device" I will add
suspend/resume support to input devices to mark all keys as "released'
unpon suspending and restore led state and repeat rate for keyboards
upon resuming.

-- 
Dmitry

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
