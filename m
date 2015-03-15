From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] hid: cp2112: support i2c_transfer() when num > 1
Date: Sun, 15 Mar 2015 13:10:20 +0100
Message-ID: <20150315121020.GA14594@katana>
References: <1426419798-25360-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426419798-25360-1-git-send-email-borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2015 at 07:43:18PM +0800, Antonio Borneo wrote:
> The device cp2112 does not support i2c combined transactions,
> since unable to suppress the stop bit between adjacent i2c
> transactions.

Let's keep the precise terminology: a 'transfer' is anything between the
start and stop bit. It can consist of multiple 'messages' which are
combined with repeated start within one transfer.

> For this reason, in commit b9029345ed6483fcadadc4834b44a5656dd56d70
> ("HID: cp2112: add I2C mode") I have omitted the support for
> num > 1 in i2c_transfer().

Good. You should make use of the quirk framework soon in linux-next or
here: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

> 1) in few kernel drivers i2c_transfer() has been used to
> simplify the code by replacing a sequence of i2c_master_send()
> and i2c_master_recv(), e.g. in i2c-hid.c and iio subsystem.
> Those drivers will fail if used with current cp2112 driver.

I see two options for those:

1) revert the simplifications and sacrifice a bit of performance
   to support the widest number of adapters
2) use the quirk infrastructure from above to query the
   quirks of the adapter to chose between fast or compatible

Keep in mind that some devices do *require* that messages are combined
with repeated start because they will reset their state machine after
stop.

> 2) in drivers/i2c/busses/ there are already drivers that
> implement i2c_transfer() as a sequence of elementary (not
> combined) i2c transactions, e.g. i2c-bcm2835.c, i2c-puv3.c,
> i2c-qup.c, i2c-robotfuzz-osif.c, i2c-viperboard.c, i2c-xlr.c.

You misread that, most probably. They are iterating over the messages,
yes, but they are expected to connect them via repeated start. If there
is a driver sending stop after every message and accepting more than one
message per transfer, this is a bug.

> To fix 1) and considering 2), rewrite i2c_transfer() in case
> of num > 1 as a loop of non-combined i2c transactions.

For the above reasons, NAK.

> In [1] we had a talk about implementing i2c_transfer() as a
> sequence of elementary (not combined) i2c transactions.
> After Jonathan's reply in [2], I went to check better the
> existing I2C drivers and I changed opinion.

And why is this driver in hid? This is clearly an I2C master driver?


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBXasAAoJEBQN5MwUoCm2AaAP/j1basHbaqYcYPF737SJKmvz
oaV5+PAs4bmj+HOiWglo959yvfxM3ZvTLgKI0nNe55/ZB+S7MQIf5lQw4hO1DJqy
fBFIwhNqXc6HQt29M0K3hJU8ByEL2fIJDCh5CziK0rFP747faWxeLf4ywgQ4lbpT
B7a0MX5yAobM3QyEdiKruj/hjhOefQzJhtvtF9JNBnIGHLFV2nZTIgrBwg/Di67W
NuncV64kEIHxvYnNYw5o/yvvQwVZIsY15JbZvk3/VbKw0DdS3GjNU9PbBmN3zyDA
Ko/IL21bVNLwYdGebwG9Gsq11i7QkVuIi6nDclcXpB6WMc0CTVBMh+aqk0D47qav
yKCCqjiNvhHHxujyiUd40LRHYMmkxdsmzoOxze+Nq26BwBoNeQ03rsXAlbhT5RmO
SxPDKvUsdl9iiXdheI32PgZSlGtOc2Fn9umWtqCYsor5gf8egZsWDTQ5vzkj0uvr
u0/sivFJc7RJMWmiShjEH6Xt73FqKXP7FZiM7iqmukUMs7BRWi2fzYnyyrvjAGpU
fstd5fHh6xcNUrPoCX5MObJgfCN4w8P1Z8xw8IrcJZ5DK7YJ2Mf0MXF+mumBMHog
9nkUG2+o86ekQ6C6VbMvmXfz/s44+ihGNJDF0bByL+GAg4kPvpF0CW8wuur1dErf
R1wW5jDUoweujojXknpS
=kfVl
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
