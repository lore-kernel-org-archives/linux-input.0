From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: wacom - Fix compiler warning if !CONFIG_PM
Date: Mon, 11 Aug 2014 10:42:38 -0400
Message-ID: <20140811144238.GA10029@mail.corp.redhat.com>
References: <1407604023-7429-1-git-send-email-geert@linux-m68k.org>
 <alpine.LNX.2.00.1408092238290.15220@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52296 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbaHKOms (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 10:42:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1408092238290.15220@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Aug 09 2014 or thereabouts, Jiri Kosina wrote:
> On Sat, 9 Aug 2014, Geert Uytterhoeven wrote:
>=20
> > If CONFIG_PM is not set:
> >=20
> > drivers/hid/wacom_sys.c:1436: warning: =E2=80=98wacom_reset_resume=E2=
=80=99 defined but
> > not used
> >=20
> > Protect the unused functions by #ifdef CONFIG_PM to fix this.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Thanks Geert.
>=20
> hid-wacom is in a sort of temporary mode of operation, being moved fr=
om=20
> Input to HID driver.
>=20
> Adding Benjamin and Dmitry to CC, as this will likely still go throug=
h=20
> Dmitry's queue.
>=20

Thanks for fixing this Geert.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
