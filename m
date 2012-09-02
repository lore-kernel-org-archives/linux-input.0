From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: input0: bad kobj_uevent_env content in show_uevent()
Date: Mon, 3 Sep 2012 00:38:31 +0800
Message-ID: <20120902163831.GA26191@localhost>
References: <20120902075946.GA21198@localhost>
 <87harg35kh.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65296 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128Ab2IBQih (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Sep 2012 12:38:37 -0400
Content-Disposition: inline
In-Reply-To: <87harg35kh.fsf@nemi.mork.no>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, chunkeey@googlemail.com, linville@tuxdriver.com, LKML <linux-kernel@vger.kernel.org>

On Sun, Sep 02, 2012 at 03:41:34PM +0200, Bj=C3=B8rn Mork wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
>=20
> > After the __devinit* removal series, I can still get kernel panic i=
n
> > show_uevent(). So there are more sources of bug..
> >
> > Debug patch:
> >
> > @@ -343,8 +343,11 @@ static ssize_t show_uevent(struct device
> >                 goto out;
> >
> >         /* copy keys to file */
> > -       for (i =3D 0; i < env->envp_idx; i++)
> > +       dev_err(dev, "uevent %d env[%d]: %s/.../%s\n", env->buflen,=
 env->envp_idx, top_kobj->name, dev->kobj.name);
> > +       for (i =3D 0; i < env->envp_idx; i++) {
> > +               printk(KERN_ERR "uevent %d env[%d]: %s\n", (int)cou=
nt, i, env->envp[i]);
> >                 count +=3D sprintf(&buf[count], "%s\n", env->envp[i=
]);
> > +       }
> >
> > Oops message, the env[] is again not properly initilized:
> >
> > [   44.068623] input input0: uevent 61 env[805306368]: input0/.../i=
nput0
> > [   44.069552] uevent 0 env[0]: (null)
>=20
> This is a completely different CONFIG_HOTPLUG problem, only
> demonstrating another reason why CONFIG_HOTPLUG should go away.  I ha=
d a
> hard time trying to disable it anyway ;-)
>=20
> The problem this time is lots of code assuming that a call to
> add_uevent_var() will guarantee that env->buflen > 0.  This is not tr=
ue
> if CONFIG_HOTPLUG is unset.  So things like this end up overwriting
> env->envp_idx because the array index is -1:
>=20
> 	if (add_uevent_var(env, "MODALIAS=3D"))
> 		return -ENOMEM;
>         len =3D input_print_modalias(&env->buf[env->buflen - 1],
> 				   sizeof(env->buf) - env->buflen,
> 				   dev, 0);
>=20
>=20
> Don't know what the best action is, given that there seem to be a *lo=
t*
> of this around the kernel.  This patch "fixes" the problem for me, bu=
t I

It also works reliably for me: 300 boots without a single failure.

Tested-by: Fengguang Wu <fengguang.wu@intel.com>=20

Thanks!
=46engguang
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
