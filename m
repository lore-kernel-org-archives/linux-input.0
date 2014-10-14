From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: rotary encoder linux driver
Date: Tue, 14 Oct 2014 18:44:33 -0400
Message-ID: <87tx366zla.fsf@gmail.com>
References: <1413163743.39490.YahooMailNeo@web160203.mail.bf1.yahoo.com> <20141014084815.GC7958@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141014084815.GC7958@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: tecfacet <tecfacet@yahoo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Johan Hovold <johan@kernel.org> writes:

> On Sun, Oct 12, 2014 at 06:29:03PM -0700, tecfacet wrote:
>> Hello.
>>=20
>> I am interested in the rotary encoder kernel driver.  I am very new to
>> this linux kernel driver thing.=20=20
>>=20
>> How do I pass the gpio and interrupt stuff to the kernel module.. I
>> think it is thru the rotary_encoder.h file.. am I correct?
>
> That should be done through the device tree these days. The binding is
> documented in
>
> 	Documentation/devicetree/bindings/input/rotary-encoder.txt
>
> in the kernel source tree.
>
You may also be interested in the device tree for a BeagleBone cape that
I recently brought up which includes an encoder,

    https://github.com/bgamari/dtb-rebuilder/blob/heaterbone-3.14/src/arm/h=
eater-bone.dtsi#L248
=20=20=20=20
Cheers,

=2D Ben


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUPadRAAoJEErkyLZmeNiDyMQH/3xfi3htAwh3+RxGf/LCBcBR
XlmM5qQXU54P4s1Bx6bJbQuKM/VXCnlGynBmoV9c+eZIkxQP0sane8ykRPKFc0M4
rYOCi7eJBdIHaBi7hBFCYgKeSRUA/ZFdSqRGLs+eAebGEOJK87gWYererZRAo1na
5pjalz+wiSRKTQJR32dKe1on/y3Fnd8hJq+aVQ35eIUrvLPdmDZexlM/ZqOw8RGh
5e6CyIv6H755Kk5QJnXJYBtfP9cru92+fe7uGxRFJwcV5qKwbZITclKbtur+Baeh
3+HOEQCMkYYBVsRXUWuRgMw/AGpknUHmF/UuhXe0rDqEXBbdFWRxhtfZO4mqCU8=
=MD7d
-----END PGP SIGNATURE-----
--=-=-=--
