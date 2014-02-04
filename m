From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Wed, 05 Feb 2014 00:54:45 +0100
Message-ID: <2759650.caO9v0gpIz@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <3580124.nFkHgCoyEf@geidi-prime> <CADbOyBS8C+OR5D6EhNCY4O-nMsb5XXdHmkN+8wzj=vT7kXy4pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:39499 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179AbaBDXyw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 18:54:52 -0500
In-Reply-To: <CADbOyBS8C+OR5D6EhNCY4O-nMsb5XXdHmkN+8wzj=vT7kXy4pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org

Hi,

I have simply taken what we have right now and ported it over to ff-mlnx.
I believe that any improvements based on the previous investigation should
go into another series because we most certainly don't want to introduce any
regressions.

Michal
