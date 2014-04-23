From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v2 01/24] input: Add ff-memless-next module
Date: Wed, 23 Apr 2014 15:31:54 +0200
Message-ID: <1398259914.32091.4.camel@linux-fkkt.site>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
	 <1398175209-9565-2-git-send-email-madcatxster@devoid-pointer.net>
	 <1398255179.32091.1.camel@linux-fkkt.site> <12060887.UbTEf5RVBB@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12060887.UbTEf5RVBB@sigyn>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Wed, 2014-04-23 at 14:30 +0200, Michal Mal=C3=BD wrote:

> > 2. That is needlessly inefficient
> Are you suggesting I drop the 'consts' and keep the memory preallocat=
ed?

Yes.

	Regards
		Oliver
