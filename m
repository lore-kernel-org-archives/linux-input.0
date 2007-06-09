From: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: [PATCH] Input: Support for a less exclusive grab.
Date: Sat, 9 Jun 2007 04:48:01 -0400
Message-ID: <20070609084800.GR6362@aehallh.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

EVIOCGRAB is nice and very useful, however over time I've gotten
multiple requests to make it possible for applications to get events
straight from the event device while xf86-input-evdev is getting events
=66rom the same device.

Here is the least invasive patch I could think of, it changes the
behavior of EVIOCGRAB in some cases, specificly behavior is identical if
the argument is 0 or 1, however if the argument is true and !=3D 1, then
it does a 'non exclusive grab', a better name might be handy.

What this does is allow the events to go to everything that's using
evdev to get events, but grabs it from anything else.  About as close to
what people want as I can get, and fairly non-invasive.

Signed-off-by: Zephaniah E. Hull <warp@aehallh.com>

---
 drivers/input/evdev.c |    6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index be6b93c..385e856 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -29,6 +29,7 @@ struct evdev {
 	struct input_handle handle;
 	wait_queue_head_t wait;
 	struct evdev_client *grab;
+	int grab_exclusive;
 	struct list_head client_list;
 };
=20
@@ -48,7 +49,7 @@ static void evdev_event(struct input_handle *handle, unsi=
gned int type, unsigned
 	struct evdev *evdev =3D handle->private;
 	struct evdev_client *client;
=20
-	if (evdev->grab) {
+	if (evdev->grab && evdev->grab_exclusive) {
 		client =3D evdev->grab;
=20
 		do_gettimeofday(&client->buffer[client->head].time);
@@ -108,6 +109,7 @@ static int evdev_release(struct inode *inode, struct fi=
le *file)
 	if (evdev->grab =3D=3D client) {
 		input_release_device(&evdev->handle);
 		evdev->grab =3D NULL;
+		evdev->grab_exclusive =3D 0;
 	}
=20
 	evdev_fasync(-1, file, 0);
@@ -493,12 +495,14 @@ static long evdev_ioctl_handler(struct file *file, un=
signed int cmd,
 				if (input_grab_device(&evdev->handle))
 					return -EBUSY;
 				evdev->grab =3D client;
+				evdev->grab_exclusive =3D ((long) p =3D=3D 1);
 				return 0;
 			} else {
 				if (evdev->grab !=3D client)
 					return -EINVAL;
 				input_release_device(&evdev->handle);
 				evdev->grab =3D NULL;
+				evdev->grab_exclusive =3D 0;
 				return 0;
 			}
=20

--=20
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

It was then I realized how dire my medical situation was.  Here I was,
a network admin, unable to leave, and here was someone with a broken
network.  And they didn't ask me to fix it.  They didn't even try to
casually pry a hint out of me.
  -- Ryan Tucker in the SDM.

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGamlARFMAi+ZaeAERAiu6AJ9I15cHO46vQUj9Gm23f5esU91WmwCeLjiY
P3dUG1i2HoJSKgr41hqGU3Q=
=UjBi
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--
