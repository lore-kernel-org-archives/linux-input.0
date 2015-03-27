From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] tc3589x OF only enforcement
Date: Fri, 27 Mar 2015 12:00:33 +0000
Message-ID: <20150327120033.GF15988@x1>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34006 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbC0MAk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 08:00:40 -0400
Received: by wgs2 with SMTP id 2so96951160wgs.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 05:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>

On Fri, 27 Mar 2015, Linus Walleij wrote:

> On Thu, Mar 19, 2015 at 3:52 PM, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>=20
> > These two patches removes the non-DT probe/config path from the
> > TC3589x driver. I suggest merging both through the MFD tree if
> > Dmitry can ACK the input patch.
>=20
> Lee it seems Dmitry ACKed these patches, can you merge those
> two patches into MFD? I don't think there will be any cross-tree deps
> so you can just carry them  in MFD without any immutable branch busin=
ess.

Change of plan.  20f02d6 scuppers you plans unfortunately.  Probably
best if this goes in via the Input tree.

Both patches unapplied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
