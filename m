From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i8042 - add Acer Aspire 5536 to the noloop list
Date: Thu, 20 Aug 2009 20:51:45 -0700
Message-ID: <20090821042316.BA5D9526EA5@mailhub.coreip.homeip.net>
References: <1250471002-20780-1-git-send-email-eugen@debian.org> <20090818055542.CB3F6526EA5@mailhub.coreip.homeip.net> <20090818165326.GA3844@localhost.localdomain> <alpine.LRH.2.00.0908191055590.2744@twin.jikos.cz> <20090819115125.GA4282@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:22583 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZHUDvt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2009 23:51:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so141235rvb.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2009 20:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090819115125.GA4282@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eugeniy Meshcheryakov <eugen@debian.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Wed, Aug 19, 2009 at 01:51:25PM +0200, Eugeniy Meshcheryakov wrote:
> 19 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2009 =D0=BE 10:56 +0200 Jiri =
Kosina =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > What chasis type do you see in the 'dmidecode' output on the affect=
ed=20
> > system?
>=20
> Notebook
>=20

I really need to see dmesg with i8042.debug to see what is going on. Th=
e
patch should only help with initial AUX discovery at startup; Eugeniy
however only has trouble re-enabling the touchpad with special button.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
