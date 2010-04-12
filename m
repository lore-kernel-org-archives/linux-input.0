From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sun, 11 Apr 2010 20:21:58 -0700
Message-ID: <20100412032158.GE29292@core.coreip.homeip.net>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
 <1270915489.3869.12.camel@lovely>
 <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:34572 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab0DLDWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 23:22:03 -0400
Received: by yxe1 with SMTP id 1so2337330yxe.33
        for <linux-input@vger.kernel.org>; Sun, 11 Apr 2010 20:22:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux@philmerk.de

On Sat, Apr 10, 2010 at 08:00:59PM +0200, St=E9phane Chatty wrote:
>=20
> Le 10 avr. 10 =E0 18:04, Christoph Fritz a =E9crit :
>=20
> >Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
> >>Added support for the eGalax dual-touch panel, found on the Asus
> >>EeePC T101MT
> >
> >>+static void egalax_remove(struct hid_device *hdev)
> >>+{
> >>+	hid_hw_stop(hdev);
> >>+	kfree(hid_get_drvdata(hdev));
> >>+	hid_set_drvdata(hdev, NULL);
> >>+}
> >
> >Why not using hid_hw_stop() instead of hid_set_drvdata()?
> >

It is used 2 lines above, isn't it?

>=20
> Er, actually for a previous driver Dmitry suggested to add this line
> and I did it without trying to understand :-)
>=20

You normally want to reset any pointers you set before, unless core doe=
s
this for you. As far as I know only i2c guys decided to move that into
core so far.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
