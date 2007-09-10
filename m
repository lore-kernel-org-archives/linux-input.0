From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] input: Fix interrupt enable in i8042_ctr when enabling
 interrupt fails
Date: Mon, 10 Sep 2007 08:59:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709100853340.24030@gandalf.stny.rr.com>
References: <877imy7kw1.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <877imy7kw1.fsf@pike.pond.sub.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Dmitry Torokhov <dtor@mail.ru>, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org


--
On Mon, 10 Sep 2007, Markus Armbruster wrote:
>
> I believe this possible, but unlikely (perhaps not so unlikely on
> virtual machines).  Scenarios involve enable succeeding the first
> time, failing the second time, and succeeding the third time.  I can
> provide details, but the point I'd like to make is not that this is
> broken (although it is, strictly speaking), but that it is not
> obviously correct where it easily could be: just clear the interrupt
> enable bits when writing them to the hardware failed, like the old
> code did.
>

I also want to stress that this is more of a clean up for "technically
correct" code than a bug fix.  This bug probably would never happen on
baremetal unless it was running on broken hardware.

  BUT!!!

With more and more systems going to a virtual environment, having a bug or
some other anomaly can trigger the error that this patch prevents. The
patch will also trigger a print in the case of running on a buggy virtual
machine, which would help out the developers of that virtual machine to
fix their code.

Please apply.

-- Steve
