From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] HID: picoLCD: off by one in dump_buff_as_hex()
Date: Sat, 22 Sep 2012 15:55:12 +0300
Message-ID: <20120922125512.GG4587@mwanda>
References: <20120914110414.GA1152@elgon.mountain>
 <20120917225437.6f2847ee@neptune.home>
 <20120919213535.34712fb5@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:24248 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2IVMzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Sep 2012 08:55:51 -0400
Content-Disposition: inline
In-Reply-To: <20120919213535.34712fb5@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Sep 19, 2012 at 09:35:35PM +0200, Bruno Pr=E9mont wrote:
> Dan,
>=20
> What's your opinion on below alternative patch?
> In addition to yours it makes would-overflow visible.
>=20
> It does not check for output buffer having non-zero size but
> as callers are local with #defined buffer size I don't think that wou=
ld
> be needed.
>=20

Sorry for the delay.  Looks good to me.

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
