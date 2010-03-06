From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with remote-wakeup settings
Date: Sat, 6 Mar 2010 16:05:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003061601520.23895-100000@netrider.rowland.org>
References: <201003062154.02199.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003062154.02199.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-hotplug@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 6 Mar 2010, Rafael J. Wysocki wrote:

> > It's not difficult in theory to tie together the WoL setting and the
> > wakeup flag:
> > 
> > 	If ethtool changes the WoL setting, the driver's ioctl handler
> > 	should make the corresponding change to the wakeup flag.
> > 
> > 	If ethtool queries the WoL setting, the ioctl handler should
> > 	check the wakeup flag.  If the flag is off, it should report 
> > 	that WoL is disabled; if the flag is on, it should report that 
> > 	WoL is enabled.  (The same check should be made in the suspend
> > 	routine.)
> 
> That's done this way already in all drivers I know, but we need a hook
> from wake_store() back to the driver.

What for?  wake_store() can't be called during a sleep transition
(because tasks are frozen) or while the system is asleep.  And if it is
called at any other time, the driver doesn't need to know until either
its ioctl handler or its suspend method runs.

Alan Stern
