From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Wed, 14 May 2014 11:14:02 -0700
Message-ID: <20140514181402.GF30089@core.coreip.homeip.net>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
 <1398524543-15012-2-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398524543-15012-2-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?iso-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 26, 2014 at 05:02:00PM +0200, Michal Mal=FD wrote:
> +
> +/** input_ff_create_mlnx() - Register a device within ff-memless-nex=
t and
> + *                           the kernel force feedback system
> + * @dev: Pointer to the struct input_dev associated with the device.
> + * @data: Any device-specific data that shall be passed to the callb=
ack.
> + *        function called by ff-memless-next when a force feedback a=
ction
> + *        shall be performed.
> + * @control_effect: Pointer to the callback function.
> + * @update_date: Delay in milliseconds between two recalculations of=
 periodic
> + *               effects, ramp effects and envelopes. Note that this=
 value will
> + *               never be lower than (CONFIG_HZ / 1000) + 1 regardle=
ss of the
> + *               value specified here. This is not a "hard" rate lim=
iter.
> + *               Userspace still can submit effects at a rate faster=
 than
> + *               this value.

The update rate change seems useful whether we use new ff implementatio=
n
or enhance the old one but I would prefer having a separate call to
control it.

Thanks.

--=20
Dmitry
