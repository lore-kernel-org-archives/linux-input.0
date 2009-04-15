From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pc110pad - remove unused variable dev
Date: Wed, 15 Apr 2009 08:39:45 -0700
Message-ID: <20090415153945.GB17335@dtor-d630.eng.vmware.com>
References: <Pine.LNX.4.64.0904151334270.10088@wrl-59.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:12637 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbZDOPj6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 11:39:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3142464rvb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2009 08:39:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904151334270.10088@wrl-59.cs.helsinki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc: linux-input@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Apr 15, 2009 at 01:38:51PM +0300, Ilpo J=E4rvinen wrote:
>=20
> dev is leftover from b0ee0d3eb31a163c958f2960906c44bcdfdc607b
> (Input: pc110pad - use no_pci_devices()).
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>

Apllied, thank you Ilpo (I could have sworn I applied similar patch
before).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
