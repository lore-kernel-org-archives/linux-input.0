From: Richard Atterer <atterer@debian.org>
Subject: Re: [PATCH 2.6.28] mousedev: Allow devices to be excluded from
	/dev/input/mice
Date: Sat, 31 Jan 2009 20:17:18 +0100
Message-ID: <20090131191718.GA11742@arbonne.lan>
References: <20090130120456.GA20461@arbonne.lan> <20090131042959.GA3529@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbZAaTRU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2009 14:17:20 -0500
Content-Disposition: inline
In-Reply-To: <20090131042959.GA3529@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry,

On Fri, Jan 30, 2009 at 08:29:59PM -0800, Dmitry Torokhov wrote:
> On Friday 30 January 2009 04:04:56 Richard Atterer wrote:
> > In my case, I'm using some mice as sensors (robotic application, mo=
re=20
> > or less), so their movement should not influence the mouse pointer =
at=20
> > all.
>=20
> I think this is the case where EVIOCGRAB use is warranted then.

Many thanks for the suggestion - that's exactly what I need! :-)

  Richard

--=20
  __   _
  |_) /|  Richard Atterer     |  GnuPG key: 888354F7
  | \/=AF|  http://atterer.net  |  08A9 7B7D 3D13 3EF2 3D25  D157 79E6 =
=466DC 8883 54F7
  =AF '` =AF
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
