From: Julien Danjou <julien@danjou.info>
Subject: Help on usb and hid-logitech-dj hacking (K750)
Date: Wed, 04 Jul 2012 00:55:13 +0200
Message-ID: <87lij0zc8e.fsf@keller.adm.naquadah.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prometheus.naquadah.org ([212.85.154.174]:55672 "EHLO
	mx1.naquadah.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2GCXDF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jul 2012 19:03:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Hi there,

I've a Logitech K750 wireless and solar keyboard, and want to retrieve
the battery level and the light meter information.

So far I've reverse-engineered the missing pieces with success, and
write a small userland utility which works and allows me to retrieve
this information. I'm attaching the code here.


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=k750-libusb.c

/* Written by Julien Danjou <julien@danjou.info> in 2012 */

#include <libusb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    libusb_context *ctx;
    libusb_init(&ctx);
    libusb_set_debug(ctx, 3);

    libusb_device_handle *device_handle = libusb_open_device_with_vid_pid(ctx, 0x046d, 0xc52b);

    fprintf(stderr, "Found keyboard 0x%p\n", device_handle);

    libusb_device *device = libusb_get_device(device_handle);

    struct libusb_device_descriptor desc;

    /* XXX check return code */
    libusb_get_device_descriptor(device, &desc);

    for(uint8_t config_index = 0; config_index < desc.bNumConfigurations; config_index++)
    {
        struct libusb_config_descriptor *config;

        /* XXX check return code */
        libusb_get_config_descriptor(device, config_index, &config);

        /* We know we want interface 2 */
        int iface_index = 2;
        const struct libusb_interface *iface = &config->interface[iface_index];

        for (int altsetting_index = 0; altsetting_index < iface->num_altsetting; altsetting_index++)
        {
            const struct libusb_interface_descriptor *iface_desc = &iface->altsetting[altsetting_index];

            if (iface_desc->bInterfaceClass == LIBUSB_CLASS_HID)
            {
                libusb_detach_kernel_driver(device_handle, iface_index);
                libusb_claim_interface(device_handle, iface_index);

                unsigned char ret[65535];

                unsigned char payload[] = "\x10\x02\x09\x03\x78\x01\x00";

                if(libusb_control_transfer(device_handle,
                                           LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
                                           LIBUSB_REQUEST_SET_CONFIGURATION,
                                           0x0210, 2, payload, sizeof(payload) - 1, 10000))
                {
                    int actual_length = 0;

                    while(actual_length != 20 || strncmp((const char *) &ret[9], "GOOD", 4))
                        libusb_interrupt_transfer(device_handle,
                                                  iface_desc->endpoint[0].bEndpointAddress,
                                                  ret, sizeof(ret), &actual_length, 100000);

                    uint16_t lux = ret[5] << 8 | ret[6];

                    fprintf(stderr, "Charge: %d %%\nLight: %d lux\n", ret[4], lux);
                }

                libusb_release_interface(device_handle, iface_index);
                libusb_attach_kernel_driver(device_handle, iface_index);
            }
        }
    }

    libusb_close(device_handle);
    libusb_exit(ctx);
}

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The problem with this approach, is that I've to detach the driver,
making some input events lost.

Therefore I'd like to add native support for this "device" in the
kernel. It's officialy supported by "hid-logitech-dj" because it's
hidden behind a Logitech Unifying receiver. I've poked into the hid
subsystem and dj-logitech a bit, but I can't really find how to do
things correctly.

As you can see, I need to send some control transfer directly over USB,
and I am not sure the HID driver is the good place to do that.
I also though about going rogue and write an USB driver, bypassing hid,
but since the Logitech Unifying Receiver is handled by hid-logitech-dj,
I'm not authorized to have another driver doing that.

Then, for now, I'm stuck because I'm not sure where to put my code. I'm
not even sure on how to export the retrieved values.

Cc'ing Nestor in case he have any idea about this.

Thanks in advance,

Cheers,
=2D-=20
        Julien

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP83hRAAoJEGEbqVCLeKXCQDMP+gKqwT12OKViXEzOl1ANh+UI
fDNAzdiUwkkb/ij1NPaVAPMZNy0KrGVJqMKO+Zo45OBY8A5GPomKcEI0U92eM0E6
9vWmNRB/FfQ/aoTuoddkZTH4TKBwRRAjeAmhWE+l6Le+vpTNaRQ0oB/DyulPkCMV
i7o/wnJFTPSvcUMNDFh+jM27T0OvoxeVaPW45zhP9qTyTaGjPVFG7zPM/cWO2s2c
C9iOadV4ii7+YPHXP+JrMZifL2G05bRu/fgdWATrUIchuv7jcb7Ilrd9PvsyDfYM
uSGJQoS2azpu5YNcBv7+cbgCpaWo/CwUDHosufy8QP1DgYSiowMbKbpkut9LcgeI
ckXiCNloxR7IyVBMsp41H6bednRG8tddIRnklNXXZD/JPRX2ROexhjcpOYm7oSZH
/Z2zv2lly0asym8pkeCv1Szvf46aNE0TkOfc+BzOodz3vN4LqZmWFxfJpQBK6Zs6
FP1lPLUk+P9vsXECsjJPVKW1KTemTL4DHwzLeDWic3g1yQR6BcnOzB3f3cdPkB/M
3mu6og63ti/Bcpu+7qBFOcu3pOd5B18YfiehQ5Nizhr+MVR3M4prIiFwS02S2egl
EmaVKfQyh5lRs7sozSwFENPiUh+B3sLyOG4wrj4bz7zLESwqbNj2oECKnV+oTPq8
Q9DN3bp1dcIAkiLlltf3
=a2Ua
-----END PGP SIGNATURE-----
--==-=-=--
