From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 06/10] regulator: AXP20x: Add support for
 regulators subsystem
Date: Fri, 28 Mar 2014 13:39:34 +0000
Message-ID: <20140328133934.GQ30768@sirena.org.uk>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-7-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+G6m7pD98ON7Rq3z"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBMHX2WMQKGQEEMB5ATA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395955764-18103-7-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--+G6m7pD98ON7Rq3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 10:29:20PM +0100, Carlo Caione wrote:

> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	int sel = regulator_map_voltage_iterate(rdev, uV, uV);
> +
> +	if (sel < 0)
> +		return sel;
> +
> +	return regulator_set_voltage_sel_regmap(rdev, sel);
> +}

This is fairly obviously broken - it's overwriting the normal runtime
value, this will disrupt the running system if we want the value we use
on suspend is different to the value we want at runtime.

Think about it - if this was a sane thing to do the core would just do
it without needing driver specific code, we already know how to set the
voltage for the device.

--+G6m7pD98ON7Rq3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXuTAAoJELSic+t+oim9s+kP/RjYAOTNNBvlaRjeuZhCP20j
VreQ5oFfOVa1U6gNnjJDHRIgzdIKVe9/bMlmh8ByF3eXnlxw8HUvKQaXEEH0Sx+1
uyB+rNQc08wallzDdH95xLR3N///EtJecg8tOLYWkLXHBpba51Gy3aJCHkhpDA9T
MjXh3gPegPIOzFMAnr8zmvGkF0r5UOvsnSoqrpGoY/ySUZ78PrV4FXw3M+5woHNr
hHRg2Db8MVRVxCZcvCXig+ksjpZIMxIoD6HPUOPp/YD6Rh5tF50c+SaoGvZ+qHw+
r/oP9xAOm1QDL500vbChJ9rkVN8kHs2ct2WfvnD1pL6qmX3PV+tKKDyst2HRcVlF
t2qHqSNCAtr41BO0wKRT9WBiArprjKExu6yNVUhPRhg0zQGQoqz0ur1NgtHZVzHE
f+u3UTo//3l3w3C5IRFbLxJEK2lJ4NTDsLNInbJYe63IxPrxHqNO12fqxF2TAX19
Tp3am7aVW81bwfp4y/o/a0vuW55LpUfuGUA4V1a9y7H/o6u/3Lg91o4AwS1uNUkE
ca0lBV3s93emjfXs6Bzm4/xS/iQg00g3f+JJ3ZLs6sLwUv+mu1BoJpQHYEydpV3m
N7zhqJn8CqGq6GMQlDapIsxDzcu/cvZu8cwB2fCGjllyAJPY1GbYg2IlP/SGfF4z
svD+AZPJkgmZstNuHOxV
=L0ZL
-----END PGP SIGNATURE-----

--+G6m7pD98ON7Rq3z--
