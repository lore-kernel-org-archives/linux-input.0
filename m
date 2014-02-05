From: simon@mungewell.org
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Tue, 4 Feb 2014 19:08:43 -0500
Message-ID: <63cea0aa616907d1186526ea155ff1d0.squirrel@mungewell.org>
References: <1602354.DiHhm9tiaI@geidi-prime>
    <CADbOyBS8C+OR5D6EhNCY4O-nMsb5XXdHmkN+8wzj=vT7kXy4pw@mail.gmail.com>
    <2759650.caO9v0gpIz@geidi-prime> <11410308.cAygrS0hGQ@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41289 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbaBEAIs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 19:08:48 -0500
In-Reply-To: <11410308.cAygrS0hGQ@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@prifuk.cz>
Cc: Elias Vanderstuyft <elias.vds@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org


> Ahh... please disregard this. 2/5 should have the same fix for zero force
> as
> we have right now - it should effectively stop the effect when the force
> is zero.

Hi,
We need to think carefully on this as a '+10' combined with '-10' force
will result in '0'; however we do not want to deactivate the wheel
(no-resistance mode) as this will result in 'ticking' on the wheel as
force transitions through 0.... ideally we'd need to know that there are
no forces set.

I'll attempt to build these patches this week and give them a test,
Simon.


