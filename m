From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Tue, 14 Aug 2012 10:31:24 -0700
Message-ID: <20120814173124.GO25632@google.com>
References: <20120730213656.0a9f6d30@neptune.home>
 <20120809200947.2194e89f@neptune.home>
 <20120813232708.GF25632@google.com>
 <20120814083044.78b401d2@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62376 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab2HNRb2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 13:31:28 -0400
Content-Disposition: inline
In-Reply-To: <20120814083044.78b401d2@pluto.restena.lu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello,

On Tue, Aug 14, 2012 at 08:30:44AM +0200, Bruno Pr=E9mont wrote:
> > I'm kinda shooting in the dark but who flushes / cancels
> > fb_info->deferred_work?
>=20
> fb_deferred_io_cleanup() does so and is called by destroy fbops
> (when last reference to fb_info is returned):

I see.  Sorry but just from glancing it I can't really tell what's
going wrong.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
