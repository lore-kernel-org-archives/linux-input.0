From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Fix interrupt enable in i8042_ctr when enabling
	interrupt fails
Date: Mon, 10 Sep 2007 09:14:52 -0400
Message-ID: <d120d5000709100614l7a4a651dl4baf64cee1414835@mail.gmail.com>
References: <877imy7kw1.fsf@pike.pond.sub.org>
	<Pine.LNX.4.58.0709100853340.24030@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0709100853340.24030@gandalf.stny.rr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>, Markus Armbruster <armbru@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-input@vger.kernel.org

Hi Steven, Markus,

On 9/10/07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> --
> On Mon, 10 Sep 2007, Markus Armbruster wrote:
> >
> > I believe this possible, but unlikely (perhaps not so unlikely on
> > virtual machines).  Scenarios involve enable succeeding the first
> > time, failing the second time, and succeeding the third time.  I can
> > provide details, but the point I'd like to make is not that this is
> > broken (although it is, strictly speaking), but that it is not
> > obviously correct where it easily could be: just clear the interrupt
> > enable bits when writing them to the hardware failed, like the old
> > code did.
> >
>
> I also want to stress that this is more of a clean up for "technically
> correct" code than a bug fix.  This bug probably would never happen on
> baremetal unless it was running on broken hardware.
>
>  BUT!!!
>
> With more and more systems going to a virtual environment, having a bug or
> some other anomaly can trigger the error that this patch prevents. The
> patch will also trigger a print in the case of running on a buggy virtual
> machine, which would help out the developers of that virtual machine to
> fix their code.
>

The patch is in my tree and will be merged in the next window.

-- 
Dmitry
