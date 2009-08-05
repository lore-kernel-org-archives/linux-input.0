From: Pavel Machek <pavel@ucw.cz>
Subject: Re: patch staging-htc-dream-touchscreen-more-cleanups.patch added
	to gregkh-2.6 tree
Date: Wed, 5 Aug 2009 17:31:34 +0200
Message-ID: <20090805153133.GB8337@elf.ucw.cz>
References: <20090721100426.GA15327@elf.ucw.cz> <12487107711539@kroah.org> <d6200be20907271736w46d51fcfled2b382655a2fef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36093 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbZHEPbk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2009 11:31:40 -0400
Content-Disposition: inline
In-Reply-To: <d6200be20907271736w46d51fcfled2b382655a2fef0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve Hj?nnev?g <arve@android.com>, linux-input@vger.kernel.org
Cc: gregkh@suse.de

On Mon 2009-07-27 17:36:24, Arve Hj?nnev?g wrote:
> On Mon, Jul 27, 2009 at 9:06 AM, <gregkh@suse.de> wrote:
> ...
> > + =A0 =A0 =A0 ts->input_dev->phys =3D "msm/input0";
>=20
> What does "msm/input0" refer to? This driver is not only used on the
> msm platform.

Ok, what should I write there? "synaptics_i2c"?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
