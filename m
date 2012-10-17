From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Mouse and keyboard freeze on Ivy Bridge platform
Date: Wed, 17 Oct 2012 13:54:01 -0700
Message-ID: <20121017205401.GF12456@elie.Belkin>
References: <20121004213606.GA8409@dinot.net>
 <Pine.LNX.4.44L0.1210051011030.1541-100000@iolanthe.rowland.org>
 <20121017201312.GA17852@dinot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37997 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab2JQUyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 16:54:06 -0400
Content-Disposition: inline
In-Reply-To: <20121017201312.GA17852@dinot.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Dinot <sebastien.dinot@free.fr>
Cc: 689368@bugs.debian.org, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi S=C3=A9bastien,

S=C3=A9bastien Dinot wrote:
> Alan Stern a =C3=A9crit :

>> In addition to what Sarah said, it's possible that your problem is
>> related to the fact that the keyboard and mouse operate at low speed=
=2E
>> If you connected them through a hub then that hub would communicate
>> with the internal hub at high speed, not low speed.
>
> I had no freeze since I bought wireless keyboard and mouse ten days a=
go.
>
> Obviously, I am satisfied by this happy end but I am surprised too
> because my previous keyboard and mouse still work fine with older
> hardware...

Thanks, that's interesting.  If you have time to test connecting the
old keyboard and mouse through a hub, that would still be useful.

Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
