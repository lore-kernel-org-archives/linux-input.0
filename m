From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 1 Dec 2015 14:11:51 -0800
Message-ID: <20151201221151.GA24202@kroah.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
 <1448996208-19713-1-git-send-email-adrienverge@gmail.com>
 <1448996208-19713-3-git-send-email-adrienverge@gmail.com>
 <alpine.LNX.2.00.1512012308160.32500@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54959 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbbLAWLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 17:11:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1512012308160.32500@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Adrien =?iso-8859-1?Q?Verg=E9?= <adrienverge@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oneukum@suse.com>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, Dec 01, 2015 at 11:09:23PM +0100, Jiri Kosina wrote:
> On Tue, 1 Dec 2015, Adrien Verg=E9 wrote:
>=20
> > All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's u=
se
> > this quirk for all devices from this vendor, rather than maintainin=
g a
> > list of all its known product IDs.
> >=20
> > Tested-by: Adrien Verg=E9 <adrienverge@gmail.com>
> > Signed-off-by: Adrien Verg=E9 <adrienverge@gmail.com>
>=20
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Reviewed-by: Jiri Kosina <jkosina@suse.cz>
>=20
> Greg, I guess it makes sense to take both 1/2 and 2/2 together as a w=
hole.=20
> Would you mind adding the tags above and taking it through usb git tr=
ee?
>=20
> Alternatively I can take it through my tree if you Ack the usb part.

Sure, I'll take it as I've already applied the non-HID patch :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
