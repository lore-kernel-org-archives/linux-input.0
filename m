From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 28 Mar 2014 11:38:39 +0000
Message-ID: <20140328113839.GB30768@sirena.org.uk>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
 <20140328101146.GP6120@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vWfgMjdKllQeoPX8"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBXV62WMQKGQEWUXNBEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140328101146.GP6120@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--vWfgMjdKllQeoPX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 11:11:46AM +0100, Maxime Ripard wrote:

> Here, you would just include the dtsi at the top of the file, and in
> the DTSI, you would have something like:

> &axp209 {
>    regulators {
>       ...
>    }
> }

Hang on, what is an include file setting up regulators for?

--vWfgMjdKllQeoPX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNV88AAoJELSic+t+oim9brsP/32lxgXB0zw7kww3qpXSXgNf
uLWuPu0eyYAAAhhu7/f/3+Jx1gcuf8UY6YYVxiNIbWneuzbX/tfHfgEdAsyVg2O8
5g3YSZ70IN95+uDasx3oovDT+KLWzf6BGGnv+c+r7SASmHNOd1SA2dsNCRC5HnM4
Pw2MEySJNqPnUxgsbV8MZowNN5kHds92gwtIsin0lLnrYJwFKcNiikGxWeVGMKMg
cod+Ne6HKUPXYQYSu10fjzw5ZAQFRFwrxpv9bfo7LS2stWmtzeME8nhEfqgYP0Nu
OCtZQHGu6ZhYmkZL8pwmDpzD90gYZM/Bg5w26/xv7Rs6zaU7h48MVcNMqTHAYoYF
Kf/HPQVjSy25fK7oGl4Kfh9Qvlbi8Czj3lYgXNKWuvdqP5/a4jXm8Sul7CU7sDPa
881QHd2XYOjkO5b+oyONQ9aRQunRtjfwlxHZSGrwjgivVtVe7e7DKGernFGvnEeV
pxOnFLoEyqx5nmiOh65ViUWnZaDiSGESzcTgFWpHLwcHbw/KBX0RquDugLQsK0bi
/w0ZL52sUTwBURC2zNUDvITAmn6Tj/1C+Ac5huVGFlGGfyvKk93AEboMAoJd5OlW
vUBJfEPD8Xe4sL7l8uprTuNI5YrnnYtAEayqVYmdoMiwm6t0VufCtmhBfTNUuSNE
XRp4O5Ps6Kk7kXTlMkHe
=+4jb
-----END PGP SIGNATURE-----

--vWfgMjdKllQeoPX8--
