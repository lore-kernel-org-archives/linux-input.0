From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: input0: bad kobj_uevent_env content in show_uevent()
Date: Sun, 2 Sep 2012 17:22:41 -0700
Message-ID: <20120903002241.GA20054@kroah.com>
References: <20120902075946.GA21198@localhost>
 <87harg35kh.fsf@nemi.mork.no>
 <20120902163831.GA26191@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120902163831.GA26191@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, chunkeey@googlemail.com, linville@tuxdriver.com, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 03, 2012 at 12:38:31AM +0800, Fengguang Wu wrote:
> On Sun, Sep 02, 2012 at 03:41:34PM +0200, Bj=F8rn Mork wrote:
> > Fengguang Wu <fengguang.wu@intel.com> writes:
> >=20
> > > After the __devinit* removal series, I can still get kernel panic=
 in
> > > show_uevent(). So there are more sources of bug..
> > >
> > > Debug patch:
> > >
> > > @@ -343,8 +343,11 @@ static ssize_t show_uevent(struct device
> > >                 goto out;
> > >
> > >         /* copy keys to file */
> > > -       for (i =3D 0; i < env->envp_idx; i++)
> > > +       dev_err(dev, "uevent %d env[%d]: %s/.../%s\n", env->bufle=
n, env->envp_idx, top_kobj->name, dev->kobj.name);
> > > +       for (i =3D 0; i < env->envp_idx; i++) {
> > > +               printk(KERN_ERR "uevent %d env[%d]: %s\n", (int)c=
ount, i, env->envp[i]);
> > >                 count +=3D sprintf(&buf[count], "%s\n", env->envp=
[i]);
> > > +       }
> > >
> > > Oops message, the env[] is again not properly initilized:
> > >
> > > [   44.068623] input input0: uevent 61 env[805306368]: input0/...=
/input0
> > > [   44.069552] uevent 0 env[0]: (null)
> >=20
> > This is a completely different CONFIG_HOTPLUG problem, only
> > demonstrating another reason why CONFIG_HOTPLUG should go away.  I =
had a
> > hard time trying to disable it anyway ;-)
> >=20
> > The problem this time is lots of code assuming that a call to
> > add_uevent_var() will guarantee that env->buflen > 0.  This is not =
true
> > if CONFIG_HOTPLUG is unset.  So things like this end up overwriting
> > env->envp_idx because the array index is -1:
> >=20
> > 	if (add_uevent_var(env, "MODALIAS=3D"))
> > 		return -ENOMEM;
> >         len =3D input_print_modalias(&env->buf[env->buflen - 1],
> > 				   sizeof(env->buf) - env->buflen,
> > 				   dev, 0);
> >=20
> >=20
> > Don't know what the best action is, given that there seem to be a *=
lot*
> > of this around the kernel.  This patch "fixes" the problem for me, =
but I
>=20
> It also works reliably for me: 300 boots without a single failure.
>=20
> Tested-by: Fengguang Wu <fengguang.wu@intel.com>=20

Thanks for figuring this out.  I'll apply it for 3.6, but work to get
rid of CONFIG_HOTPLUG completly for 3.7 as it just causes problems.

greg k-h
