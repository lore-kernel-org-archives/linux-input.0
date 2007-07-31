From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] Refresh lid state on resume
Date: Tue, 31 Jul 2007 15:42:26 +0200
Message-ID: <200707311542.27571.rjw@sisk.pl>
References: <1184670921.8890.2.camel@work> <1185872842.2652.11.camel@hughsie-laptop> <1185878536.18821.129.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1185878536.18821.129.camel@queen.suse.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: trenn@suse.de
Cc: Richard Hughes <hughsient@gmail.com>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, 31 July 2007 12:42, Thomas Renninger wrote:
> On Tue, 2007-07-31 at 10:07 +0100, Richard Hughes wrote:
> > On Tue, 2007-07-31 at 11:08 +0200, Rafael J. Wysocki wrote:
> > > On Monday, 30 July 2007 17:33, Richard Hughes wrote:
> > > > On Mon, 2007-07-30 at 17:21 +0200, Thomas Renninger wrote:
> > > > > On Tue, 2007-07-17 at 12:15 +0100, Richard Hughes wrote:
> > > > > > On resume we need to refresh the lid status as we will not get =
an event if
> > > > > > the lid opening was what triggered the suspend.
> > > > > > This manifests itself in users never getting a "lid open" event=
 when a
> > > > > > suspend happens because of lid close on hardware that supports =
wake on
> > > > > > lid open. This makes userspace gets very confused indeed.
> > > > > > Patch inline (and also attached) forces a check of the lid stat=
us in the
> > > > > > resume handler.
> > > > > Is this a general problem on all machines?
> > > >=20
> > > > I've only seen myself it on new ThinkPads such as the T61 and X60,
> > > > although I've been getting a few bug reports about other IBM laptop=
s.
> > > >=20
> > > > > Or does this only happen if "shutdown" suspend mode is used?
> > > >=20
> > > > No, I don't believe so.
> > > >=20
> > > > > I could imagine a lot machines let it up to OS to check for LID s=
tate
> > > > > change, then this one should be added.
> > > >=20
> > > > I guess it's up to the BIOS, and I don't think this refresh hurts a=
ny
> > > > machines that implement a notify on resume, and fixes a fair few
> > > > machines that don't.
> > >=20
> > > AFAICS, the notify doesn't seem to work very well on some machines.
> >=20
> > Agree.
> >=20
> > > Are there any downsides of the $subject patch?
> >=20
> > Not that I've found. I've been testing it on ~6 IBM and non-IBM machines
> > with no bad effects so far.
>=20
> I just checked a X60 DSDT (couldn't check the SSDTs, but I doubt there
> is anything related):
> There are two Notify(\_SB.LID,0x80), both are in GPE handlers.
> AFAIK there should be one in the _WAK function.

Well, we only enable GPEs after calling _WAK, so this one won't trigger.

Perhaps we should change the code ordering in acpi_leave_sleep_state() to
enable GPEs before executing _WAK?

> Maybe they try to raise the GPE after wakeup in _WAK by something like
> this:
> \VSLD (\_SB.LID._LID ())
> ....
> Method (VSLD, 1, NotSerialized)
>     {
>         SMI (0x01, 0x07, Arg0, 0x00, 0x00)
>     }
> :)
>=20
>=20
> Related ACPI Spec parts:
>=20
> 6.3 Device Insertion, Removal, and Status Objects:
> The Notify command can also be used from the _WAK control method (for
> more information about _WAK, see section 7.3.7 =E2=80=9C\_WAK (System Wak=
e)=E2=80=9D) to
> indicate device changes that may have occurred while the computer was
> sleeping. For more information about the Notify command,
> see section 5.6.3 =E2=80=9CDevice Object Notification.=E2=80=9D.=E2=80=9D
>=20
> The X60 is definitely not doing this.
>=20
> The transition from Working to Sleep state is described very detailed,
> but I couldn't find (just overseen?) a detailed description about the
> transition from Sleep State to working state.
> In detail I searched for whether first the GPEs should get enabled and
> then _WAK is called or the other way around (the latter is currently
> implemented).
> Maybe enabling GPEs before calling _WAK will also fix this

Well, my thought above. :-)

> (and is the way it should be done or at least the way M$ is doing it?).

I don't know ...

> Richard, could you give attached patch a try, pls.
> Also check that platform suspend mode is used. AFAIK this isn't called
> at all in suspend mode.
>=20
> Thanks,
>=20
>     Thomas
>=20
> -----------------------
>=20
> Enable GPEs before calling _WAK on resume
>=20
> Signed-off-by: Thomas Renninger <trenn@suse.de>
>=20
> ---
>  drivers/acpi/hardware/hwsleep.c |   31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> Index: linux-2.6.22.1/drivers/acpi/hardware/hwsleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22.1.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6.22.1/drivers/acpi/hardware/hwsleep.c
> @@ -562,6 +562,23 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  	arg_list.pointer =3D &arg;
>  	arg.type =3D ACPI_TYPE_INTEGER;
> =20
> +	/*
> +	 * GPEs must be enabled before _WAK is called as GPEs
> +	 * might get fired there
> +	 *
> +	 * Restore the GPEs:
> +	 * 1) Disable/Clear all GPEs
> +	 * 2) Enable all runtime GPEs
> +	 */
> +	status =3D acpi_hw_disable_all_gpes();
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +	status =3D acpi_hw_enable_all_runtime_gpes();
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +

I wouldn't move that before _BFS, just in case someone actually implements =
it.

Enabling GPEs just prior to calling _WAK should be safe, IMO.

>  	/* Ignore any errors from these methods */
> =20
>  	arg.integer.value =3D ACPI_SST_WAKING;
> @@ -582,22 +599,8 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  	}
>  	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
> =20
> -	/*
> -	 * Restore the GPEs:
> -	 * 1) Disable/Clear all GPEs
> -	 * 2) Enable all runtime GPEs
> -	 */
> -	status =3D acpi_hw_disable_all_gpes();
> -	if (ACPI_FAILURE(status)) {
> -		return_ACPI_STATUS(status);
> -	}
>  	acpi_gbl_system_awake_and_running =3D TRUE;
> =20
> -	status =3D acpi_hw_enable_all_runtime_gpes();
> -	if (ACPI_FAILURE(status)) {
> -		return_ACPI_STATUS(status);
> -	}
> -
>  	/* Enable power button */
> =20
>  	(void)

Greetings,
Rafael


=2D-=20
"Premature optimization is the root of all evil." - Donald Knuth
