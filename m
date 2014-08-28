From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 2/2] HID: picolcd: sanity check report size in
 raw_event() callback
Date: Thu, 28 Aug 2014 07:57:04 +0200
Message-ID: <20140828075704.3207e228@pluto>
References: <alpine.LNX.2.00.1408270911130.2992@pobox.suse.cz>
	<alpine.LNX.2.00.1408270912310.2992@pobox.suse.cz>
	<20140827101311.098f3fd1@pluto>
	<alpine.LNX.2.00.1408271025040.2992@pobox.suse.cz>
	<alpine.LNX.2.00.1408272331250.21233@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:44088 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbaH1F5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Aug 2014 01:57:08 -0400
In-Reply-To: <alpine.LNX.2.00.1408272331250.21233@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Aug 2014 23:32:00 +0200 (CEST) Jiri Kosina wrote:
> On Wed, 27 Aug 2014, Jiri Kosina wrote:
>=20
> > > Is it worth adding report->id to this hid_warn()?
> > >=20
> > > A valid device is not expected to ever send >64 bytes reports but=
 in
> > > case a firmware update would do so it would help to know for whic=
h
> > > report it was.
> >=20
> > It definitely wouldn't hurt. Pull request with the original patch i=
s now=20
> > on its way to Linus though, so let's do this as a followup patch on=
 top=20
> > once this is merged.
>=20
> I've just queued the below for 3.18.

Looks good,
Thanks

Bruno

> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: picolcd: be more verbose when reporting report =
size error
>=20
> picolcd device is not expected to send any report with size larger th=
an 64=20
> bytes.
>=20
> If this impossible event happens (sic!), print also a report ID to al=
low=20
> for easier debugging.
>=20
> Suggested-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-picolcd_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd=
_core.c
> index 020df3c..c1b29a9 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -351,8 +351,8 @@ static int picolcd_raw_event(struct hid_device *h=
dev,
>  		return 1;
> =20
>  	if (size > 64) {
> -		hid_warn(hdev, "invalid size value (%d) for picolcd raw event\n",
> -				size);
> +		hid_warn(hdev, "invalid size value (%d) for picolcd raw event (%d)=
\n",
> +				size, report->id);
>  		return 0;
>  	}
> =20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
