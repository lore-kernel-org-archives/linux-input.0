From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 19:35:49 +0200
Message-ID: <87tykqc7wq.fsf@tac.ki.iif.hu>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
	<20101005174106.GA21399@core.coreip.homeip.net>
	<4CAC340B.90207@codeaurora.org>
	<33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
	<1286358518.26914.23.camel@4fid08082> <20101013071106.GC1610@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101013071106.GC1610@ucw.cz> (Pavel Machek's message of "Wed,
	13 Oct 2010 09:11:06 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Onkalo Samu <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-input@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> For mobile devices it is not acceptable to filter events away at some
>> upper SW layer depending on the system state. The HW which generates
>> those events may not generate events at all to allow longer CPU sleep
>> periods.
>
> Ok.
>
>> In ideal world it would be nice to control device states based on for
>> example user count. However, there are several listeners for input
>> devices and it is hard or impossible to have them all to follow overall
>> state transition (screen blanked etc.). Instead, there is some
>> system
>
> So you have mobile device; why is it impossible to just close the
> device when you do not want the events? I guess it is hard for generic
> distros, but on your phone, you should be able to modify Xserver to
> close touchscreen/keypad device when it is not needed... right?

We'd had this discussion before... cf. eg.
http://thread.gmane.org/gmane.linux.kernel.input/9266/focus=9767

The problem was that several processes may have a device open, while
another process should be able to control the state of the device.
Maybe this could be solved by making the controlling process a proxy,
and having all "user" processes going though it.  Then the controlling
(proxy) process could open/close the device as it wants, letting the
runtime PM do its job.  But this would mean duplicating some kernel
functionality (at least multiplexing) in user space.
-- 
Regards,
Feri.
