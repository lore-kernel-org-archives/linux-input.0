From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - Fix compiler warning if !CONFIG_PM
Date: Tue, 12 Aug 2014 10:00:33 -0700
Message-ID: <20140812170033.GA5563@core.coreip.homeip.net>
References: <1407604023-7429-1-git-send-email-geert@linux-m68k.org>
 <alpine.LNX.2.00.1408092238290.15220@pobox.suse.cz>
 <20140811144238.GA10029@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33619 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaHLRAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 13:00:36 -0400
Content-Disposition: inline
In-Reply-To: <20140811144238.GA10029@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 11, 2014 at 10:42:38AM -0400, Benjamin Tissoires wrote:
> On Aug 09 2014 or thereabouts, Jiri Kosina wrote:
> > On Sat, 9 Aug 2014, Geert Uytterhoeven wrote:
> >=20
> > > If CONFIG_PM is not set:
> > >=20
> > > drivers/hid/wacom_sys.c:1436: warning: =E2=80=98wacom_reset_resum=
e=E2=80=99 defined but
> > > not used
> > >=20
> > > Protect the unused functions by #ifdef CONFIG_PM to fix this.
> > >=20
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >=20
> > Thanks Geert.
> >=20
> > hid-wacom is in a sort of temporary mode of operation, being moved =
from=20
> > Input to HID driver.
> >=20
> > Adding Benjamin and Dmitry to CC, as this will likely still go thro=
ugh=20
> > Dmitry's queue.
> >=20
>=20
> Thanks for fixing this Geert.
>=20
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
