Return-Path: <SRS0=PE//=32=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF974C2D0B1
	for <linux-input@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C99E206CC
	for <linux-input@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFLON (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:14:13 -0500
Received: from orion.archlinux.org ([88.198.91.70]:33198 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbgBFLOM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2020 06:14:12 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 8E5C118B2E11F7;
        Thu,  6 Feb 2020 11:14:09 +0000 (UTC)
Received: from localhost (dragon.archlinux.org [IPv6:2a01:4f8:13a:102a::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Thu,  6 Feb 2020 11:14:08 +0000 (UTC)
Message-ID: <451e552444483c52a038d3d14391611f897582f4.camel@archlinux.org>
Subject: Make the hid-logitech-dj driver remove the HID++ nodes when the
 device disconnects
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     linux-input <linux-input@vger.kernel.org>
Cc:     Benjamin Tissoires <btissoir@redhat.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Julien Hartmann <juli1.hartmann@gmail.com>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wM+IjAFPSxwVHsYetjnr"
Date:   Thu, 06 Feb 2020 11:14:05 +0000
MIME-Version: 1.0
User-Agent: Evolution 3.34.3 
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--=-wM+IjAFPSxwVHsYetjnr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Right now the hid-logitech-dj driver will export one node for each
connected device, even when the device is not connected. That causes
some trouble because in userspace we don't have have any way to know if
the device is connected or not, so when we try to communicate, if the
device is disconnected it will fail.

The reason we do this is because otherwise we would loose the first
packets when the device is turned on by key press. When a device is
turned on we would have to create the device node, and the packets
received while we are creating the device node would be lost. This
could solved by buffering those packets, but that is a bad solution as
it would mess up the timings.

At the moment the created node includes both normal HID and vendor
usages. To solve this problem, I propose that instead of creating a
single device node that contains all usages, we create one for normal
HID, which would exist all the time, and one for the vendor usage,
which would go away when the device disconnects.

This slight behavior change will affect userspace. Two hidraw nodes
would be created instead of one. We need to make sure the current
userspace stacks interfacing with this would be able to properly handle
such changes.

What do you think of this approach? Anyone has a better idea?

If you are CCed you might be maintaining one of the affected userspace
stacks, if so, please let me know your project is able to handle this.
If not, I can help you adapt to the new behavior.

Thank you,
Filipe La=C3=ADns

--=-wM+IjAFPSxwVHsYetjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl479P0ACgkQ+JPGdIFq
qV1dlRAAjoORT7zEOQ9NXozUWT8nkm+EiPRhEbYNfrsdhyLYbzzBgFpVfNoxlK5k
GkFaQeKSSduKZsHd/hXONebshBE9NsIbhxgqOS6Hx3Otwmr7ZFha0Gv7WHU7kVhU
Kf04UVxc0ftJEc4aV7PJhfSLC6V73GEPEXWmQiT3ZRqvZcwyn2WDNrUNmEvJanIk
x4iSQoF0g+j5YfOYyQhZe2Cs9KuIoYZQwn/Vub5sv3J+UUyyz4Jj48Vz/XsI9xPb
L+BvPJRJU8/dcVbZ78nG35DP2MN/dls+gV2uUH9JhMgo2JRaLE+24m3Wc4p7XmZ9
08g5XNnUSX9XtRRfY1CxhMUPjEHQ9grT0jV/BG9k2r/QdhtCNFib2z3uqgyTfQ9W
UVh5OgSRRHjOz4sz/UVhKU9RoNBQr2YwdE/sA/ujx0M/0dYV2s3pCWd+eO/SUT3x
FEzKRNjASCqdAtG9gVUDagvtubwrvLVzyxb5O4AgfHejuppB0c+RlNMhINC9F7gj
h1BKuAtputvRC+sMevmvZ3YjPPbNarpk6tk82atu2Gkdyw5O7FSt0hjR/Cupj88h
BD6dGsTfjix0hZcicjL9zptaYgQkTD4nyamfcSM25jKkKfXdZ5iOYzbltryyDJLb
kHpOk6Q/j/pWfC0inp4lrWmZ8kGovhbk37J6jjX1n/HlmdhZERQ=
=3IQ3
-----END PGP SIGNATURE-----

--=-wM+IjAFPSxwVHsYetjnr--
